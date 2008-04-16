From: Junio C Hamano <junio@pobox.com>
Subject: Re: [GIT PULL] sh updates for 2.6.25
Date: Wed, 16 Apr 2008 13:02:42 -0700
Message-ID: <7vve2hpnz1.fsf@gitster.siamese.dyndns.org>
References: <20080415172333.GA29489@linux-sh.org>
 <alpine.LFD.1.00.0804151048060.2879@woody.linux-foundation.org>
 <20080415183023.GA23098@linux-sh.org>
 <alpine.LFD.1.00.0804151222350.2879@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 16 22:10:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmDr5-0000R4-CO
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 22:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127AbYDPUC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 16:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751699AbYDPUC6
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 16:02:58 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35597 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009AbYDPUC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 16:02:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D2B1539DC;
	Wed, 16 Apr 2008 16:02:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 2A9F039DA; Wed, 16 Apr 2008 16:02:51 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79734>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Ahh, looks like a git-am buglet then. It will indeed turn an empty subject 
> line into an empty first line.
>
> We should run "git stripspace" on the whole thing, so maybe a patch 
> something like the appended will help.
>
> NOTE! Totally untested! Beware the patch!

The basic idea is very sound and as usual your patch deletes more lines
than it adds, which always impresses me.  I wish all our patches are like
this.

> @@ -388,6 +383,7 @@ do
>  			;;
>  		esac
>  	esac
> +	FIRSTLINE=$(head -1 "$dotest/final-commit")
>  
>  	resume=
>  	if test "$interactive" = t
> @@ -408,7 +404,6 @@ do
>  		[aA]*) action=yes interactive= ;;
>  		[nN]*) action=skip ;;
>  		[eE]*) git_editor "$dotest/final-commit"
> -		       SUBJECT=$(reread_subject "$dotest/final-commit")

This needs to be replaced with re-assignment to FIRSTLINE, as the user may
have fixed the title in the editor; otherwise...

> @@ -431,7 +426,7 @@ do
>  		stop_here $this
>  	fi
>  
> -	printf 'Applying %s\n' "$SUBJECT"
> +	printf 'Applying %s\n' "$FIRSTLINE"

... this would surprise the user who expects us to give the report with
the updated title.
