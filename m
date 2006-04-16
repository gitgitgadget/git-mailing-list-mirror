From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [FYI] generated completions
Date: Sun, 16 Apr 2006 04:05:26 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604160401330.31461@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Apr 16 04:05:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUwdo-00012p-PZ
	for gcvg-git@gmane.org; Sun, 16 Apr 2006 04:05:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWDPCFa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 22:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbWDPCFa
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 22:05:30 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:59546 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932191AbWDPCF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Apr 2006 22:05:29 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 80C041C0F
	for <git@vger.kernel.org>; Sun, 16 Apr 2006 04:05:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 7562F1BF2
	for <git@vger.kernel.org>; Sun, 16 Apr 2006 04:05:26 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 61F281BE1
	for <git@vger.kernel.org>; Sun, 16 Apr 2006 04:05:26 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18771>

Hi,

I just played around with command line completion in bash, mainly to 
distract me from the work I have to do.

This is a shell script which generates a completion script from the 
documentation. It is very dumb at the moment, but at least a start. I am 
not likely to continue with this in the near future, so everyone who's 
interested: go wild.

--- generate-completions.sh ---
#!/bin/sh

cat << EOF
function gitcomplete ()
{
	case "\$COMP_LINE" in
EOF

cmds=""
for file in Documentation/git-*.txt; do
	cmd=$(expr $file : "Documentation/git-\(.*\).txt")
	cmds="$cmds $cmd"
	echo "	git\ $cmd\ *)"
	echo '		case "$3" in'

	# get all lines which begin with '-' or '<' and end with '::',
	# because they likely contain a command line option
	sed -n "s/^\([-<].*\)::/\1/p" < $file | { \
		opts=""
		while read line; do
			# some lines have the form '-a|--all'
			opt1=$(expr "$line" : '^\([^ |<]*\)')
			opt2=$(expr "$line" : '|\([^ |<]*\)')
			opts="$opts $opt1 $opt2"
			# this is an example how to handle non-simple args:
			# '-m <msg>' means: if the second-last arg is '-m',
			# the current arg is the message.
			test "$(expr "$line" : ".*<msg>")" != 0 &&
				echo "		'$opt1')" &&
				echo '			COMPREPLY=(\"a \"z);;'
		done
		echo "		*)"
		echo "			COMPREPLY=(\$(compgen -W \"$opts\" -- \$2));;"
	}
	echo "		esac;;"
done

cat << EOF
	git\ *\ *)
		COMPREPLY=();;
	git\ *)
		COMPREPLY=(\$(compgen -W '$cmds' -- \$2));;
	esac
}

complete -o default -F gitcomplete git
EOF
--- cut ---
