From: Shawn Pearce <spearce@spearce.org>
Subject: git push keeps writing after server failure
Date: Fri, 12 Jun 2015 10:31:33 -0700
Message-ID: <CAJo=hJvzjnLFhF4REBzX=pgFamBfu7hZeZidy_8Rmi_DwwR4Nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 12 19:32:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3SoB-00040g-Uj
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 19:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638AbbFLRbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 13:31:55 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:33525 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbbFLRby (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 13:31:54 -0400
Received: by wiwd19 with SMTP id d19so24200328wiw.0
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 10:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=DqDFVXHbhlAG8G4imOenjQgVV52l6Mw6aI1hrmS3Arc=;
        b=I3UPgW26ALzaBR0fOZ/0XUjxHX5NLCmT530SU4TRoo3WVpsH+IroexEFLYpR817F3Z
         PKdI2IuhrOLSZjKVdJBMca7PYXJhiZoaOcodRXJYF/HNB47KKTSrrUQAiF2AQFGPHxkn
         zdBSiazWkJN0TycvqVHZuySSvMYFYk/oUnQjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=DqDFVXHbhlAG8G4imOenjQgVV52l6Mw6aI1hrmS3Arc=;
        b=jP3buhbtTJyD4SDauwoV86UgOEQGI4W0XfBPeHCGnZxkiJxMwTVzLwk/Nnv20jT3YE
         ctVDWaTi8lgDs8aSkBei0/2srZJSolwTlYAvU6Q1/TczfmCgsI4DzzqBl10IUxKXQ5+3
         x4BJuHOvstl/DOdymTbXXyh9T2meUTWVVdGen640qbO/aTZnA7fw9E+PzPX4HpKYkWBo
         wwp4DPyY+Wr61tynmEfawHlbAqbpNZtNw0PitTpG0idUCJnDIOZrr8WMCUA2jBwYxDsd
         cpAzg2KBfuroKiFRcj+1XNSmw37PKh3CIwbvLcIllby5Bw6uX4eBi7YfqruSs4PbUZBp
         xvKA==
X-Gm-Message-State: ALoCoQliEHs14gobkV5qjhB31TkCXJGwm9FUeyuj7Y42aFaNH5+cluREls7M+sZELQ1KsvXPDRrj
X-Received: by 10.180.14.193 with SMTP id r1mr8845175wic.47.1434130313759;
 Fri, 12 Jun 2015 10:31:53 -0700 (PDT)
Received: by 10.28.49.134 with HTTP; Fri, 12 Jun 2015 10:31:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271501>

I did something stupid like trying to push a copy of WebKit[1] into my
GitHub account. This is ~5.2 GiB of data, which GitHub prefers not to
accept. Ok ...

$ git push --all git@github.com:spearce/wk.git
Counting objects: 2752427, done.
Delta compression using up to 12 threads.
Compressing objects: 100% (442684/442684), done.
remote: fatal: pack exceeds maximum allowed size
Writing objects: 100% (2752427/2752427), 5.28 GiB | 8.86 MiB/s, done.
Total 2752427 (delta 2225007), reused 2752427 (delta 2225007)
fatal: The remote end hung up unexpectedly
fatal: The remote end hung up unexpectedly

Notice GitHub prints "remote: fatal: pack exceeds maximum allowed
size". That interrupted my "Writing objects" progress meter, and then
git push just kept going and wrote really really fast (170 MiB/s!)
until the entire pack was sent.

A similar thing happens on https:// if the remote HTTP server goes
away in the middle of sending the pack. Except its slower to send the
remainder of the pack before git push finally terminates with an
error.

Shouldn't git push realize its stream is broken and stop writing when
the peer is all like "uh, no, I'm not going to do that, but thanks for
trying"?


[1] https://webkit.googlesource.com/WebKit/
