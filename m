From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: [PATCH v0] fast-import: Add drop command
Date: Sun, 25 Sep 2011 03:19:57 +0600
Message-ID: <CA+gfSn8Z7Xn1hdpqNHiP3bd2KGRqcAc6O683Z4O+G=jNNYJtBA@mail.gmail.com>
References: <1316878065-11782-1-git-send-email-vitor.hda@gmail.com>
	<1316878065-11782-2-git-send-email-vitor.hda@gmail.com>
	<20110924193733.GB10955@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Vitor Antunes <vitor.hda@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <davidbarr@google.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 24 23:20:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7Ze1-0007ZP-9Y
	for gcvg-git-2@lo.gmane.org; Sat, 24 Sep 2011 23:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752504Ab1IXVUA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Sep 2011 17:20:00 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:47917 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497Ab1IXVT7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Sep 2011 17:19:59 -0400
Received: by qyk30 with SMTP id 30so8501375qyk.19
        for <git@vger.kernel.org>; Sat, 24 Sep 2011 14:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=bUfsUPIAQqwboencH0lljLbsk4Ks6/2gYqTiUkH8GXw=;
        b=qJvoChgsXDh8Vbi/aq7WCBmGeMgJHKNVFZer39pEhNd9cr87clyIzqCfanaPbvVhzM
         4NkrWJDd0K7qIXuGxtSNwNZW/8pshC9eQh5QW6vd4JevOzZuiGsRzrN+iq7LGZXwGyJl
         d6wBi8ThDnqZIG0fouURiYaJAHcGDAcHkyAyg=
Received: by 10.229.69.130 with SMTP id z2mr3777720qci.16.1316899197718; Sat,
 24 Sep 2011 14:19:57 -0700 (PDT)
Received: by 10.229.224.17 with HTTP; Sat, 24 Sep 2011 14:19:57 -0700 (PDT)
In-Reply-To: <20110924193733.GB10955@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182044>

On Sun, Sep 25, 2011 at 1:37 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Vitor Antunes wrote:
>
>> The drop command deletes the given branch reference, allowing
>> fast-import to actively ignore it in the final checks.
>
> Thanks. =A0I must have missed the earlier discussion. =A0What are the
> semantics of this command and its intended purpose?
My guess is that if fast-import is used to manage a set of "remote"
branches, it should be able to delete branches. Then, it should
be allowed to do non-fastforward updates too (--force). Why can't
it just ignore branches deletion (considering --force)?

Random thoughts:
1. once 'drop' is executed, fast-import can't tell if the branch was
actually deleted. And moreover any attempt to read this branch
head becomes illegal (either it's missing in .git or fast-import is
instructed to use a dropped branch).
2. 'reset' command is a bit like proposed 'drop' but it never deletes
a branch ref. Consider following imports:
1) import branch topic
2) reset topic
3) import branch topic2 starting at topic (incorrect import)
If 1-3) is done in one fast-import process, the error is reported.
If 3) is done separately, it succeeds but the result is strange:
topic2 isn't started from scratch but from old "erased" topic.
So, maybe, reset should be fixed to erase branches on --force.

One more scenario is:
1) import topic
2) reset topic
3) import topic
If 1-3) go together - no error
If 3) goes separate - no error, but non-fastforward update.
Much more harmless, but still may look strange.

>=A0For example, what
> happens if the branch already existed or if there is a checkpoint
> (perhaps triggered by the impatient user sending SIGUSR1 to
> fast-import) before the "drop" command is processed?
I think that actual ref deletion should take place in update_branch().
So all the cases would be handled as usual.

> Jonathan
>
