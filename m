From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add path-limiting to git-add--interactive
Date: Thu, 22 Nov 2007 01:45:48 -0800
Message-ID: <7vd4u27gvn.fsf@gitster.siamese.dyndns.org>
References: <7vk5obb09a.fsf@gitster.siamese.dyndns.org>
	<1195695384-41329-1-git-send-email-win@wincent.com>
	<7vpry27id0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 10:46:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv8dS-0003dJ-7s
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 10:46:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbXKVJp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 04:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbXKVJp4
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 04:45:56 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:36574 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbXKVJpz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 04:45:55 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 45DB72F0;
	Thu, 22 Nov 2007 04:46:16 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 6A767977BD;
	Thu, 22 Nov 2007 04:46:12 -0500 (EST)
In-Reply-To: <7vpry27id0.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 22 Nov 2007 01:13:47 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65765>

Junio C Hamano <gitster@pobox.com> writes:

> Wincent Colaiuta <win@wincent.com> writes:
>
>> @@ -56,9 +56,14 @@ sub list_modified {
>>  	my ($only) = @_;
>>  	my (%data, @return);
>>  	my ($add, $del, $adddel, $file);
>> +	my @tracked = grep {
>> +		defined run_cmd_pipe(qw(git ls-files
>> +			                --exclude-standard --), $_)
>> +	} @ARGV;
>> +	return if $#tracked == -1 && $#ARGV != -1;
>
> Eek.  why?
>
> Did you mean to say:
>
>     my @tracked = run_cmd_pipe(gw(git ls-files --exclude-standard --) @ARGV);
>
> It would also make sense to use --error-unmatch and perhaps --with-tree=HEAD
> like git-commit.sh does.

Actually, the ls-files need to be chomped, but I'd prefer to
run -z form of the command and split with NUL.  Does run_cmd_pipe()
crap^Wstuff support that?

On top of:

 * refactor patch_update_cmd,
 * teach builtin-add to pass multiple paths,
 * add path-limiting to git-add--interacgtive (with an obvious
   suggested above),

the attached patch teaches [p]atch subcommand to take multiple
selections.  With these, you can do:

	$ git add -i 'u*.h'
	What now> p
                   staged     unstaged path
          1:    unchanged        +1/-0 unpack-trees.h
          2:    unchanged        +1/-0 utf8.h
        Patch update>> *
        diff --git a/unpack-trees.h b/unpack-trees.h
	...
        Stage this hunk [y/n/a/d/?]? y
        ...
	diff --git a/utf8.h b/utf8.h
        ...

-- >8 --
git-add -i: allow multiple selection in [p]atch subcommand

This allows more than one files from the list to be chosen from
the patch subcommand instead of going through the file one by
one.

This also updates the "list-and-choose" UI for usability.  When
the prompt ends with ">>", if you type '*' to choose all
choices, the prompt immediately returns the choice without
requiring an extra empty line to confirm the selection.

---
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 9236ffc..372dc2c 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -256,7 +256,7 @@ sub list_and_choose {
 				$chosen[$i] = $choose;
 			}
 		}
-		last if ($opts->{IMMEDIATE});
+		last if ($opts->{IMMEDIATE} || $line eq '*');
 	}
 	for ($i = 0; $i < @stuff; $i++) {
 		if ($chosen[$i]) {
@@ -563,12 +563,12 @@ sub patch_update_cmd {
 	@mods = grep { !($_->{BINARY}) } @mods;
 	return if (!@mods);
 
-	my ($it) = list_and_choose({ PROMPT => 'Patch update',
-				     SINGLETON => 1,
-				     IMMEDIATE => 1,
-				     HEADER => $status_head, },
-				   @mods);
-	patch_update_file($it->{VALUE}) if ($it);
+	my (@them) = list_and_choose({ PROMPT => 'Patch update',
+				       HEADER => $status_head, },
+				     @mods);
+	for (@them) {
+		patch_update_file($_->{VALUE});
+	}
 }
 
 sub patch_update_file {
