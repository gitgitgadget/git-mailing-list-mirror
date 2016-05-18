From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv7 5/5] pathspec: allow querying for attributes
Date: Wed, 18 May 2016 12:42:00 -0700
Message-ID: <CAGZ79kaMU=H7x7Gxfk39No42kxNdrqykMyx+uD7gjDsK087m1g@mail.gmail.com>
References: <20160518190222.28105-1-sbeller@google.com> <20160518190222.28105-6-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 18 21:42:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b37M7-0001gt-NK
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 21:42:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752673AbcERTmD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 15:42:03 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35450 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbcERTmC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 15:42:02 -0400
Received: by mail-ig0-f182.google.com with SMTP id bi2so101554593igb.0
        for <git@vger.kernel.org>; Wed, 18 May 2016 12:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Bo6bLGPp90R3roCSMxgEn14NZPkK09YOE+RCjOjr4Uc=;
        b=ZGx/bJ67QNd6S13GTmxiXJ+YKVJYVULoWTiaN1dK6rOX1EYEVt0VzcOwy2pOPnlxix
         v4h0F8FG/7bbq2xUCEkd5tLmIfiCPZQL6jW8zpXDWgzQBpFSUj4P+0/A3Tcagrnrb/Xr
         CIHxMUOVU0O1qIJxcoiLoU2jdZtq2aX3jMI6Ei2SnNk4JTog0fFXpX9OxRp910eee1gP
         FHzBvPGKVc7v65AUkKNks2JLVy3qGk9dB0Oi3QAXMikps7LDtMs9EQZRXSqv4HBNduxM
         1AhaGvlgpsTjtEooUzPde3XPP1fLi1CXgpPclY8Q2wg3aPSkqTrB38lQ28mTEGpT8WbS
         57dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Bo6bLGPp90R3roCSMxgEn14NZPkK09YOE+RCjOjr4Uc=;
        b=TS1KFfeR3fQksO06xlRXFc5uKK0KShX9dtOV531/Ytr0eii1VAysq9NIqJL8pdhd11
         JShPzjzE8e+I+qLqhwM989aX4MtPG16Bx/d/ojjpotw2+JluluIkFd7BdtgSo8wT3eHs
         GjeVtSWbZsvvqok+6ylgO+tHri2ye9BUJ9E66PG8+N3TZAKkY4CmTn3AosrtNwy8Q6TN
         EacX0ptv09pAaI+nyVX7Vs4EqnsaTUMyznwFtiz2ADxKnJQUCc9k54VLlYa3yIPbArQg
         GbNub9JlP1XYnipSrJ9l12mQL+mJrIofBVF0lKPqVfRMf+QOv4HcAnVal1/OURqRqylV
         FNQQ==
X-Gm-Message-State: AOPr4FX2UAFdFTWkFvTP8BtrWbuFcbVF4EBQRoEkNBZfzrLecTo3GMXl4ZUX9zJFouyaR1SWEt/sCdQf7RBua2Kt
X-Received: by 10.50.30.228 with SMTP id v4mr7012864igh.85.1463600520877; Wed,
 18 May 2016 12:42:00 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Wed, 18 May 2016 12:42:00 -0700 (PDT)
In-Reply-To: <20160518190222.28105-6-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294996>

On Wed, May 18, 2016 at 12:02 PM, Stefan Beller <sbeller@google.com> wrote:
>  void free_pathspec(struct pathspec *pathspec)
>  {
> +       int i, j;
> +       for (i = 0; i < pathspec->nr; i++) {
> +               for (j = 0; j < pathspec->items[j].attr_match_nr; j++)
> +                       free(pathspec->items[i].attr_match[j].value);
> +               free(pathspec->items[i].attr_match);
> +               git_attr_check_free(pathspec->items[i].attr_check);

This is faulty as may be NULL and git_attr_check_free assumes its
argument is not
NULL. So I'll add a guard here in a reoll.
