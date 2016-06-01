From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Segfault in the attr stack
Date: Wed, 1 Jun 2016 15:17:24 -0700
Message-ID: <CAPc5daXuQAeWvJAciRA_Kzyoxa=atEntGzKhqzjiN+ho6TnQyg@mail.gmail.com>
References: <CAGZ79ka_4vZfNhgOyMeFKdossO-S5Q7RVnvEzB8YAJNc1YQ+uQ@mail.gmail.com>
 <CAGZ79kbSKgS42nAShsK3JV78geam3k84=ipWRx7vbRODuHcmcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 00:17:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8ESU-0001fw-8B
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 00:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbcFAWRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 18:17:46 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:34228 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867AbcFAWRp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 18:17:45 -0400
Received: by mail-yw0-f173.google.com with SMTP id c127so32687462ywb.1
        for <git@vger.kernel.org>; Wed, 01 Jun 2016 15:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=wj3dAcd5SLG8ZTFxwU53nlycbmhL1yYMLN7eUfFm/sE=;
        b=wrst4lZZbux4TrN2sSQG2ltSJx8Feff86rxkfjTPNSQYk8EXYMjROox/aIJo1p336o
         JunHkNSxmYzWv+r+R/3DTwBM0RoGFCnj/QLAhLhhF1/M6HMsWfJyqIaedB6QnCYIDs5W
         /HyMfi/DnPGjFo05gzhzJAQBuxpM2KRwtfpLFNJy1hPmpadTyykA12H9QcgbySDXlQwh
         8YgHyQZZkiYlmfbk8Bz7AmaK+UrkhWZK8jpIFRUyznYsy28PGngsJC08Q8hopNN6mWUn
         YLpeW7To5JD40lGqdLO7t3l28+J3Ca4ZWRJbHIt7epgCR8nqRZEvQFYTPJOIm7bmUV+Z
         YvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=wj3dAcd5SLG8ZTFxwU53nlycbmhL1yYMLN7eUfFm/sE=;
        b=DhnowZy4tENNMOrQcZmToqYjVx9HVB5C7pCuRX+MReP7B40aA4N/RDi+/X4V+BXMNC
         OpNb3jsUmQ7JTPrQVie1PYfSluSXh3o6xtji/+of3anYOLWfh9Bpoa8fzVT7TWvu97sZ
         UzY6sPnPyNH7ahZ/tMlY+TtrB1T4FsQBuj6n8U5BIBMEHV/92E2rEr7TwKktFrrOyDHG
         3fXo2GZe8JiKQ0I8BRpBa8UMVbphli75m/N+x+OS3EEwTPvzrhil/9Lkin2or8TfjTaI
         G8yJAyMMSgR/AkCW0ny/fr52g7p++ru+rlmuo1Y+6PkrFpGzwxBo+/8ALIcKAN/65KrG
         x6tw==
X-Gm-Message-State: ALyK8tIYRweqwQ02nfJdpv9KocZKHzS9IAoSnDV8kl5BwNwi0BwQk8pQDANxUjX/zYLrH+OgL9wPVYhpSpVBwA==
X-Received: by 10.129.80.139 with SMTP id e133mr4287721ywb.197.1464819464025;
 Wed, 01 Jun 2016 15:17:44 -0700 (PDT)
Received: by 10.13.251.71 with HTTP; Wed, 1 Jun 2016 15:17:24 -0700 (PDT)
In-Reply-To: <CAGZ79kbSKgS42nAShsK3JV78geam3k84=ipWRx7vbRODuHcmcA@mail.gmail.com>
X-Google-Sender-Auth: n_2xfpjJZCtNsPfjff_o20vyLAc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296172>

Gaah, of course.

This is coming from the cache preload codepath, where multiple threads
try to run ce_path_match().
It used to be OK because pathspec magic never looked at attributes,
but now it does, and attribute system is not thread-safe.

On Wed, Jun 1, 2016 at 3:11 PM, Stefan Beller <sbeller@google.com> wrote:
> This can be reproduced on sb/pathspec-label in git.git as well.
>
> The key difference I notice is `git ls-files` works perfectly (e.g. in
> the tests)
> while `git status` fails.
