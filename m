From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 00/44] Make git-am a builtin
Date: Mon, 13 Jul 2015 15:31:37 -0700
Message-ID: <xmqqh9p7y9iu.fsf@gitster.dls.corp.google.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 14 00:31:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEmGG-0001Sb-9S
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jul 2015 00:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302AbbGMWbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2015 18:31:40 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:36777 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507AbbGMWbj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2015 18:31:39 -0400
Received: by ieik3 with SMTP id k3so32475966iei.3
        for <git@vger.kernel.org>; Mon, 13 Jul 2015 15:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=paBNOTELCi7VYqAKbAf7W7hmQmpMaIDDur69G+QGuIw=;
        b=D4wYynxeXHF7EvQq+qKtQqSUWO1wVQT0AyYLK0Nb7Jwo1E0j9SsNilDcXyBHi2mqUc
         DaKohFw9rg00nvYQj5hJ3CT5GxbKa0bI5oKHfKZAyzDyKRw+8X4iUVhKZ40V3yxDkTtc
         VsGrRgZ6Y/ER6wut5LuBP4AlOouAmns6OPM0rNqNNNmpuxI2cuM7SoXAMpCrNyOcJfYR
         bq8yqRe6XHzDfcJqAS8pm5rCZ4OgINJORwcfgZIy8KYumINCSWbomK32GuV9WZkhc/lG
         dy3iGd/6LvkPhTMIg+hHAzkjbGYmFA9MwnyjlTHjV9caDg83Vlhqv9iYojN9+qnusQaj
         uwUQ==
X-Received: by 10.50.49.46 with SMTP id r14mr15573845ign.45.1436826698782;
        Mon, 13 Jul 2015 15:31:38 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4d10:ec6a:e89:91cb])
        by smtp.gmail.com with ESMTPSA id j4sm6617840igo.0.2015.07.13.15.31.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 Jul 2015 15:31:38 -0700 (PDT)
In-Reply-To: <1436278862-2638-1-git-send-email-pyokagan@gmail.com> (Paul Tan's
	message of "Tue, 7 Jul 2015 22:20:18 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273933>

While using this series for real work today, I found another bug
that is unfortunately a show-stopper for my workflow.

Store 7 patches from David Turner to a file, ./+dt-7, starting at
http://thread.gmane.org/gmane.comp.version-control.git/273786 and
then:

  $ git checkout master...dt/refs-backend-preamble
	... "git checkout 912bd49" is also fine ...
  $ git am -s ./+dt-7

This stops while applying 6th patch, like so:

  Applying: update-ref and tag: add --create-reflog arg
  error: patch failed: builtin/update-ref.c:431
  error: builtin/update-ref.c: patch does not apply
  Patch failed at 0006 update-ref and tag: add --create-reflog arg
  The copy of the patch that failed is found in:
     /usr/local/google/home/jch/w/git.git/.git/rebase-apply/patch
  When you have resolved this problem, run "git am --continue".
  If you prefer to skip this patch, run "git am --skip" instead.
  To restore the original branch and stop patching, run "git am --abort".

This is expected, but the recovery from this state is what goes
wrong.  At this point, one of the usual thing to do is to

  $ edit .git/rebase-apply/patch

and match the offending preimage to what the working tree has.

In this case, the conflict is found near the end of
builtin/update-ref.c, where the call to delete_ref() in the
pre-context of the hunk at around ll.413,+10 was

	return delete_ref(refname, oldval ? oldsha1 : NULL, flags);

but in the newer codebase, the line is split further and the
pre-context would show just

	flags);

the latter of which is what $gmane/273793 expects.  

A fix is to edit the patch to replace that "flags);" line with full
"return delete_ref()" line and save it.  Then running

  $ git am

(no argument) is supposed to read from the corrected patch file and
continue the application.

This no longer works with the version with this series, it seems.
