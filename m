From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/3] name-rev: strip trailing ^0 in when --name-only
Date: Mon, 8 Jul 2013 18:30:07 +0530
Message-ID: <CALkWK0mrOfx-EfS3YfS7mMBKqjFrwcyiVmQO=wMLN-BH1avqBg@mail.gmail.com>
References: <1373200996-9753-1-git-send-email-artagnon@gmail.com>
 <1373200996-9753-3-git-send-email-artagnon@gmail.com> <7vd2qu44mm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 15:00:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwB3n-00064r-Oo
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 15:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265Ab3GHNAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 09:00:51 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:59298 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226Ab3GHNAt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 09:00:49 -0400
Received: by mail-ie0-f173.google.com with SMTP id k13so9722956iea.4
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 06:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FsyLBPPsXH6KzX3yGOEiqZ/e/1viEXddS2S5QHY29Bc=;
        b=KA6IPyhtL4G9qpiWSEWAiSQB/AG2aanWHv3tcO7sz8gJPzdfIs6fHL2jBp0N2djulJ
         xqtqaa3LsAMwbB6rOKbJxN4mxJ1yc7AQtvEHqnM2KaiccoiwqSIVxfDyLWPYdQg+/i+7
         c4tletvNKjlkEuzJjgoRU50vYYDC7vll21xgXOoFglfGYlzg798p/acWWbsedBVxvbm+
         8mnIbv0M8o8Fpsw4JhWwa9cBupnZw229FosZkTp63hABPAOyzACRoo+W2mhYtrm9n9Kr
         QqRfrNGkxPUhHh3qIcCQOveRCYXM6y/9XYHvJEM/cobHm8DQrSvAs4nmR9KpDlKzb+03
         1nUQ==
X-Received: by 10.50.6.16 with SMTP id w16mr8649400igw.29.1373288449192; Mon,
 08 Jul 2013 06:00:49 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Mon, 8 Jul 2013 06:00:07 -0700 (PDT)
In-Reply-To: <7vd2qu44mm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229845>

Junio C Hamano wrote:
> But I do not think "name-rev" is limited
> to commits, in the sense that you would see this:
>
>     $ git rev-parse v1.8.3 v1.8.3^0 | git name-rev --stdin
>     8af06057d0c31a24e8737ae846ac2e116e8bafb9
>     edca4152560522a431a51fc0a06147fc680b5b18 (tags/v1.8.3^0)
>
> The second object is _not_ v1.8.3 but is v1.8.3^0 in the context of
> name-rev, whose purpose is to give you a string you can feed
> "rev-parse" and get the object name back.  "rev-parse v1.8.3" will
> not give you the commit object name, so you need to keep "^0".

Quite frankly, I thought the unstripped ^0 in one codepath was an
unintended quirk.  What exactly do you want name-rev to give you?

  $ git tag foo @^
  $ git name-rev foo
  foo tags/foo

So you can distinguish between annotated tags, unannotated tags, and
head-refs.  Can you get it to tell you anything reliably though?

  $ git tag bar @
  $ git tag -a baz @
  $ git name-rev @
  $ git name-rev bar
  $ git name-rev baz

ref, annotated, or unannotated tag?  I do not think name-rev is
fundamentally different from describe: it is also only dependent on
the commit history graph.  Whether I specify a revision using @, HEAD,
baz, or bar, I should get the same answer (it's just a recursive
peeler).  I'm not sure what you gain by knowing the object type of the
output.  If you wanted to feed something into rev-parse and get out a
commit, you'd send in $REV^0 without bothering about what it is, no?
