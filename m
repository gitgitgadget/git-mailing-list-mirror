From: Junio C Hamano <gitster@pobox.com>
Subject: Re: repository corruption when pushing commits to a repository running 'git gc --prune='
Date: Wed, 14 Oct 2015 10:37:43 -0700
Message-ID: <xmqqoag18i6w.fsf@gitster.mtv.corp.google.com>
References: <561E5C5B.3090207@alcatel-lucent.com>
	<vpq4mhtbjma.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jan Smets <jan.smets@alcatel-lucent.com>, <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Oct 14 19:37:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmPzr-0005Hi-T6
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 19:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932602AbbJNRhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 13:37:47 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33322 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932555AbbJNRhp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 13:37:45 -0400
Received: by pabrc13 with SMTP id rc13so60201724pab.0
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 10:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=zWffXIWdW6gZ5ayQ1U8CPoM4/PfNnCI+oAJfnTYgl1o=;
        b=NenNNoE88Ws561uN0TmoRdH+zOvHVBPmgXozwPjPOi+ATB6GRU3iP27eh3n9VBtGoV
         LUSERwve/+lYP859AxNmq1Ihc2MqVXONmo+ugfw3IQs270SVTWSkXbSgWTlwiP96TQSA
         bo2X2uKe2Hek/7+pC1bhpaS05FhRl2OSyJMyyZisXVjuri8+2rnOnCwS/phqHPFe7rgK
         PlJksViOXVYVxPvyDR4wAOjlkezXwDPXA9m0NBUIaqn3RLtKOSQBfDFJx81U7VOcrC/j
         PUHtNulVzVbc9PhKUrNgvGxMo7gSkPOs6Ny6KVDhy13vEdHxXJ2JTy4L3pxv0FqJz4tD
         Y1sg==
X-Received: by 10.67.4.230 with SMTP id ch6mr4937212pad.11.1444844264853;
        Wed, 14 Oct 2015 10:37:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:45f3:915b:d2ba:37bc])
        by smtp.gmail.com with ESMTPSA id iy1sm10756838pbb.85.2015.10.14.10.37.43
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Oct 2015 10:37:44 -0700 (PDT)
In-Reply-To: <vpq4mhtbjma.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Wed, 14 Oct 2015 16:38:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279583>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> I think this is the expected behavior. push will create new objects that
> are not referenced until the ref is updated (at the very end). prune can
> run concurrently since creating and deleting objects is done in a
> lockless way (only the ref update needs a lock).
>
> Still, this is not the *documented* behavior, and an easy way to corrupt
> a repo should be very explicitly documented as very dangerous, and the
> precautions to take when using it should be explained clearly.

Yeah, I think this paragraph in the user-manual is the only thing
that mentions it:

    Anyway, once you are sure that you're not interested in any dangling
    state, you can just prune all unreachable objects:

    ------------------------------------------------
    $ git prune
    ------------------------------------------------

    and they'll be gone. (You should only run `git prune` on a quiescent
    repository--it's kind of like doing a filesystem fsck recovery: you
    don't want to do that while the filesystem is mounted.

Something along this line, perhaps?

 Documentation/git-gc.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 5223498..fa15104 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -63,8 +63,11 @@ automatic consolidation of packs.
 --prune=<date>::
 	Prune loose objects older than date (default is 2 weeks ago,
 	overridable by the config variable `gc.pruneExpire`).
-	--prune=all prunes loose objects regardless of their age.
-	--prune is on by default.
+	--prune=all prunes loose objects regardless of their age (do
+	not use --prune=all unless you know exactly what you are doing.
+	Unless the repository is quiescent, you will lose newly created
+	objects that haven't been anchored with the refs and end up
+	corrupting your repository).  --prune is on by default.
 
 --no-prune::
 	Do not prune any loose objects.
