From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb using "--cc"?
Date: Thu, 09 Feb 2006 13:53:00 -0800
Message-ID: <7voe1g8air.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602081532360.2458@g5.osdl.org>
	<43EAA560.8030504@didntduck.org>
	<Pine.LNX.4.64.0602081817040.2458@g5.osdl.org>
	<7vu0b9jkad.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602090822100.2458@g5.osdl.org>
	<Pine.LNX.4.64.0602091029310.2458@g5.osdl.org>
	<7v3bisb9qn.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602091216460.2458@g5.osdl.org>
	<Pine.LNX.4.64.0602091235210.2458@g5.osdl.org>
	<7v8xsk9s3v.fsf@assigned-by-dhcp.cox.net>
	<7v4q389rwi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 22:53:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7Jj3-0007Vw-2c
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 22:53:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWBIVxE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 16:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWBIVxD
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 16:53:03 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:4524 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750715AbWBIVxC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2006 16:53:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060209214945.FGOI20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Feb 2006 16:49:45 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7v4q389rwi.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 09 Feb 2006 12:52:13 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15832>

Junio C Hamano <junkio@cox.net> writes:

> Junio C Hamano <junkio@cox.net> writes:
>
>> So obviously it would show the final paths and would not talk
>> about which different path from each parent contributed to the
>> result, but otherwise it should not be broken too much.  At
>> least that was the way I intended..
>
> Sorry, I am wrong again.  That was the way how I planned to, but
> I think I forgot to pass the diff-options from the caller to
> diff_tree_combined_merge(), so it does not do renames/copies.
>
> Shouldn't be too hard to change it though...

On top of your patch, it was quite easy ;-)

After the "Evil merge" in your test script, I added these:

        for i in a b c d e f g h i j k l m n; do echo $i; done >d
        git-update-index --add d
        git commit -m 'Add d'

        git checkout other
        git merge fast HEAD master

        mv d e
        echo o >>e
        git-update-index --add --remove d e
        git commit -m 'Move-edit d to e'

        git checkout master
        git merge -s recursive 'Merge' HEAD other

        git diff-tree -M --cc HEAD

diff --git a/combine-diff.c b/combine-diff.c
index 15f369e..2a0ec10 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -829,7 +829,7 @@ const char *diff_tree_combined_merge(con
 	struct combine_diff_path *p, *paths = NULL;
 	int num_parent, i, num_paths;
 
-	diff_setup(&diffopts);
+	diffopts = *opt;
 	diffopts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diffopts.recursive = 1;
 
