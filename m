From: Shawn Pearce <spearce@spearce.org>
Subject: send-pack silently tries to recreate funny remote refs
Date: Mon, 6 Jul 2015 22:56:57 -0700
Message-ID: <CAJo=hJuWAh8ctKp=BOR_0cMg3Y=rk6Lq++qXQpj+2jsZkfSUhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 07 07:57:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCLsi-0003tJ-Ak
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 07:57:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832AbbGGF5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 01:57:20 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:34423 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbbGGF5S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 01:57:18 -0400
Received: by wgfr2 with SMTP id r2so2825802wgf.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 22:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=BYErhZRvhxZXSkDimz5k5swBxFhIDW9Xf1i7hkKGWsE=;
        b=XBPfW+1BxCyKK46yO6sQ4QnMZwgnaCyswoeL2HbUX/gRYeI4TbQw7fzFQoFF2FGODM
         YTZpiE/+9g+xQ9P8t/yFkEYL0NCeB68AuipWYZqsWjjMNGE2gZLfOX78Qtxd504M9E8i
         j1MVrlYWNEO7ysUezKLPTaT0qtsN5EECLisIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=BYErhZRvhxZXSkDimz5k5swBxFhIDW9Xf1i7hkKGWsE=;
        b=JEXPGRvtEyBSc2XyzT/ywwDum5WxAGum8HZVZ9Lp4RYmtv7JUzuwQ3Z8K6gmR/6wmd
         BD0q4frl33kWAP6ekMU5JSOVXgUOdGPsFCAMH0XbXv89u659fJQGsCu3jIeVTNW+sX38
         bUezaWFxd7G/uYU65ioWO1En+8ubU9vZM5rH94gucQqvlOwTpk3ULhU2Bv1B4SwTkn0o
         IsEjr9+VLiIHUtBtky4e3iABv/LM7x3EusQAEn2D6Gtz0WzcoVvpttRfmUuN+c5O8RNW
         EFWDhNwecT2rmOsZVlwx23Ef9seMH6VeN427HaSNehWPwdAYeT0pwV8UGJy7TlEEhHXF
         3M9w==
X-Gm-Message-State: ALoCoQkhExOYPLIphYVhZh9/w2dI1weTNcGjWMYJPnwH/sJaR+cVMvIOAralp7oBnWf2bHO3+99L
X-Received: by 10.194.93.3 with SMTP id cq3mr4894153wjb.20.1436248637331; Mon,
 06 Jul 2015 22:57:17 -0700 (PDT)
Received: by 10.28.228.70 with HTTP; Mon, 6 Jul 2015 22:56:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273477>

Today I learned that git push will silently try to recreate a remote
funny ref if you push to it.

"Hypothetically" ... lets say I have a reimplementation of Git called JGit.
Lets say its on a server somewhere on the network.
Lets say its a bit more liberal in what it accepts...

$ git push origin HEAD^:refs/wtf
Counting objects: 3, done.
Writing objects: 100% (3/3), 206 bytes | 0 bytes/s, done.
Total 3 (delta 0), reused 0 (delta 0)
To ...blahblah.../wtf
 * [new branch]      HEAD^ -> refs/wtf

Okaaaay. We are the proud new owners of

$ git ls-remote origin
4da022e5c7e2c33025374ddd1c3aeeb082d7b394        refs/wtf

Yea. Great.

Here is the WTF. git push will silently send a creation command
instead of an update.

$ GIT_TRACE_PACKET=1 git push origin HEAD:refs/wtf
22:48:09.277446 pkt-line.c:46           packet:         push<
4da022e5c7e2c33025374ddd1c3aeeb082d7b394 refs/wtf\0 side-band-64k
delete-refs report-status quiet ofs-delta agent=JGit/4-...
22:48:09.277522 pkt-line.c:46           packet:         push< 0000
22:48:09.277595 pkt-line.c:46           packet:         push>
0000000000000000000000000000000000000000
f721fb36771dc587d45e8a95ef9f7edcc3849236 refs/wtf\0 report-status
side-band-64k agent=git/2.4.3.573.g4eafbef
22:48:09.277605 pkt-line.c:46           packet:         push> 0000
Counting objects: 6, done.
Delta compression using up to 12 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (6/6), 409 bytes | 0 bytes/s, done.
Total 6 (delta 0), reused 0 (delta 0)
22:48:09.419038 pkt-line.c:46           packet:         push<
\1000eunpack ok001fng refs/wtf already exists0000
22:48:09.419066 pkt-line.c:46           packet:         push< 0000
22:48:09.419073 pkt-line.c:46           packet:         push< unpack ok
22:48:09.419082 pkt-line.c:46           packet:         push< ng
refs/wtf already exists
22:48:09.419092 pkt-line.c:46           packet:         push< 0000
To rpc://user/sop/wtf
 ! [remote rejected] HEAD -> refs/wtf (already exists)
error: failed to push some refs to '...blahblah.../wtf'


I think the cause is get_remote_heads() gets passed REF_NORMAL during
send-pack, which filters out that refs/wtf advertisement from the
server. Once its filtered out send-pack thinks the ref is new and
happily sends along the command to create it.

In git-core this rejection of the funny ref is done at the server.
This JGit server was fine with the funny ref. It didn't care earlier
when git push created it.

Now git push isn't so happy with that funny ref on the RHS, because it
always forgets it in the advertisement. This makes it hard to update
the ref. Or delete it remotely.

If we don't want that ref in the advertisement, push should refuse it
in the RHS.
If we want to let the remote decide, send-pack should honor the advertisement.
