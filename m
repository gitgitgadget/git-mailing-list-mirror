From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] read-cache: fix reading of split index
Date: Tue, 24 Mar 2015 20:02:36 +0700
Message-ID: <CACsJy8CYi+hYu8zwOy=m7zZk3-8fr+Jq9uT4kEf8fLCOcjHJzw@mail.gmail.com>
References: <20150320195943.GB6545@hank> <1426887794-9655-1-git-send-email-t.gummerer@gmail.com>
 <1426887794-9655-3-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jaime Soriano Pastor <jsorianopastor@gmail.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 14:03:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaOUI-0002hi-B0
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 14:03:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbbCXNDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 09:03:10 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:36810 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531AbbCXNDI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 09:03:08 -0400
Received: by igbud6 with SMTP id ud6so70855378igb.1
        for <git@vger.kernel.org>; Tue, 24 Mar 2015 06:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=A/gd9X8R9y0eMv9T4+8Y3EMQyhkadZDLVu8SnQZcHtM=;
        b=e7n5IHU42JtodZQxe61UjEmNvSbgd5GZprVIFJY7Io00eKgV3nHLG8xNSEJXUBGSuV
         36lBAk+AchrzDezoxB3AXYgiKlONS1YCougeHxttlIR275NtVLMeNlTYn6GVG67XRTIE
         lFxb86AnMggWFVz5z/WGp2LjkCku9BM+XCurYmgQP+HwM9YQI8UoCLXiOePiaVuleWKR
         2tyGFQXcED/xjkx3BJJ/OTJgnwCvGu6zj0mYv67cWIuqyWLvY3rxVJRxE6ikU0P6Yz/8
         /DrzGxNlqzXpAXgG7YlsZyUcv7lolY8rp6yEp5JA6gvvipn5t9ObD0He3uoTWrD6e/yH
         IBdQ==
X-Received: by 10.42.184.199 with SMTP id cl7mr25480032icb.39.1427202187038;
 Tue, 24 Mar 2015 06:03:07 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Tue, 24 Mar 2015 06:02:36 -0700 (PDT)
In-Reply-To: <1426887794-9655-3-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266185>

On Sat, Mar 21, 2015 at 4:43 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> The split index extension uses ewah bitmaps to mark index entries as
> deleted, instead of removing them from the index directly.  This can
> result in an on-disk index, in which entries of stage #0 and higher
> stages appear, which are removed later when the index bases are merged.
>
> 15999d0 read_index_from(): catch out of order entries when reading an
> index file introduces a check which checks if the entries are in order
> after each index entry is read in do_read_index.  This check may however
> fail when a split index is read.
>
> Fix this by moving checking the index after we know there is no split
> index or after the split index bases are successfully merged instead.

Thank you for catching this. I was about to write "would be nice to
point out what tests fail so the reviewer has easier time trying
themselves", but whoa.. quite a few of them!

May I suggest a slight modification. Even though stage info is messed
up before the index is merged, I think we should still check that both
front and base indexes have all the names sorted correctly (and even
stronger, the base index should never contain staged entries). If
sorting order is messed up, it could lead to other problems. So
instead of removing the test from do_read_index(), perhaps add a flag
in check_ce_order() to optionally detect the stage problem, but
print/do nothing, only set a flag so the caller know there may be a
problem. In the two new call sites you added, we still call the new
check_ce_order() again to make sure everything is in order. In the
call site where split index is not active, if the previous
check_ce_order() call from inside do_read_index() says "everything is
ok", we could even skip the check.
-- 
Duy
