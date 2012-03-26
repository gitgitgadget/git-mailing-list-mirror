From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [GSOC 2012] Some questions regarding a possible project to
 improve big file support
Date: Mon, 26 Mar 2012 08:21:53 +0700
Message-ID: <CACsJy8CQHbwCQGypVRgKhD9Wb4O6kXGoDLD9EUZgnBP-6ZivMw@mail.gmail.com>
References: <4F6F8489.20108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: "Peter C." <th3flyboy@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 03:22:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBydi-0002fT-5g
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 03:22:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754234Ab2CZBWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Mar 2012 21:22:25 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:50535 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754023Ab2CZBWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2012 21:22:25 -0400
Received: by wejx9 with SMTP id x9so3867020wej.19
        for <git@vger.kernel.org>; Sun, 25 Mar 2012 18:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jJnyNakkgxP0XddUiuioriTLhdcv9aQ+V4ftolJ+0Fg=;
        b=OYRGIRaUlPZP2tCtA6HxNamSoTWyxFqKDTFz30z2VgLuOU6FoDQ7MzCEsz3HIyuMBs
         sNosF+LdS9ejXxWD3S0VzYzcJFJTsQuzDOmGjHCMAb59AzL7YEGJNXtGcMQPPpKD6/fd
         xmXUOIAQxxAKvjpm6mxk07M0wXCd7aFdTKyDXYoEN8ZhTrYsB5ePrQ5zylD8UcdOgHay
         Odze6dQLMfmTWjzk8D3VrmURFlwKWm/ZQhBii6ChjD5EzEx/cCDoFR3gL1T3SFcejCiz
         0gPuH6GbGh8BnTIQ8/M6lSy3mG0stjPz9ywW1Q5VXO10Nn45LI7gEjjefRi2c4BuKhyK
         0BIg==
Received: by 10.180.80.40 with SMTP id o8mr14180719wix.10.1332724943892; Sun,
 25 Mar 2012 18:22:23 -0700 (PDT)
Received: by 10.223.109.144 with HTTP; Sun, 25 Mar 2012 18:21:53 -0700 (PDT)
In-Reply-To: <4F6F8489.20108@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193889>

On Mon, Mar 26, 2012 at 3:48 AM, Peter C. <th3flyboy@gmail.com> wrote:
> My first question is more of a question regarding low level
> functionality of how Git diffs files. The question is, in the diff
> process, does git just parse the file and see if there are diffs, or
> does it use something like hashing to first tell if the file has been
> modified at all, and then go to the diff process if the hash is
> different. An extension to this question is, in Git's internal database,
> does it set any kind of flag to say that a file is a binary if it is one.

If hashes are available, we compare hash first (e.g. diff-tree). We
can mark a file binary with gitattributes. I think the binary
detection code, buffer_is_binary, could be just moved up a little bit
before we unpack file contents. But I'm not really familiar with this
area.

> My thought process in implementation involves checking the hash, and if
> the hash is the same, skip it, if the hash is different, check the MIME
> type possibly using libmagic, and if it matches a known binary format,
> then just commit the new version, rather than trying to run a whole diff
> and load the whole file in the process.

Overkill, compared to how binary is detected today :)

#define FIRST_FEW_BYTES 8000
int buffer_is_binary(const char *ptr, unsigned long size)
{
	if (FIRST_FEW_BYTES < size)
		size = FIRST_FEW_BYTES;
	return !!memchr(ptr, 0, size);
}

If you are interested in this big file support, I think you should
focus on the "Many large files do not delta well..." item in the wiki
page. The framework has already been done by Junio. That can make git
manage gigabyte files just fine (aka "bup").
-- 
Duy
