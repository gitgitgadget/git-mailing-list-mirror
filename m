From: Csaba Henk <csaba-ml@creo.hu>
Subject: git "manifest" command
Date: Tue, 5 Jun 2007 10:03:18 +0000 (UTC)
Message-ID: <slrnf6ad74.4vk.csaba-ml@beastie.creo.hu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 05 12:10:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvW01-0001qQ-ND
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 12:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763735AbXFEKKl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 06:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763732AbXFEKKl
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 06:10:41 -0400
Received: from main.gmane.org ([80.91.229.2]:54697 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763468AbXFEKKk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 06:10:40 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HvVzG-0004rN-VD
	for git@vger.kernel.org; Tue, 05 Jun 2007 12:10:02 +0200
Received: from www.creo.hu ([217.113.62.14])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Jun 2007 12:10:02 +0200
Received: from csaba-ml by www.creo.hu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Jun 2007 12:10:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: www.creo.hu
User-Agent: slrn/0.9.8.1 (FreeBSD)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49178>

Hi,

I was lacking a "manifest" like command, one which operates like
git-ls-files just you can use it with arbitrary tree-ish (or, put it
otherwise, one which opererates like git-ls-tree just acts recursively).
Maybe it's there already and I just didn't find my way through git
glossary?

Anyway, I rolled my own. Chanches are you find it an useful addition.

Csaba

------[git-manifest.sh]---8<---------------------------------------
#!/bin/sh
#
# Copyright (c) 2007 Csaba Henk 

display() {
	if [ $verbose ]
	then
		echo -n $1 $2 $3" "
        fi
        echo "$4"
}

walk() {
	git-ls-tree "$1" | while read -r mode type sha name
	do
		if [ "$type" = tree ]
		then
			display $mode $type $sha "$2$name/"
			walk $sha "$2$name/"
		else
			display $mode $type $sha "$2$name"
		fi
	done
}

help() {
    echo \
"List content of tree-ish recursively. Usage:

`basename "$0"` [-v] <tree-ish>
" >&2
    exit
}

case $# in
    1|2) ;;
    *)
       help 
esac

verbose=
if [ $# -eq 2 ]
then
	if [ "$1" = -v ]
	then
		verbose=1
	else
		help
	fi
	shift
else
	case "$1" in
		-h|--help) help
	esac
fi

walk "$1"
