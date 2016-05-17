From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 09/12] attr: (re)introduce git_check_attr() and struct git_attr_check
Date: Tue, 17 May 2016 00:19:59 -0400
Message-ID: <CAPig+cR5ksdATefkYkG7-+a_nK0w+Fdu8ae-Z4=PTp8yAYhiQQ@mail.gmail.com>
References: <20160516210545.6591-1-gitster@pobox.com>
	<20160516210545.6591-10-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 17 06:20:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2WUM-00074I-28
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 06:20:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636AbcEQEUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 00:20:04 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:32864 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604AbcEQEUC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 00:20:02 -0400
Received: by mail-io0-f193.google.com with SMTP id x35so1288251ioi.0
        for <git@vger.kernel.org>; Mon, 16 May 2016 21:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=c3IEd/ZvFvmNljGfIKQJSRIYXpfUeaIdE9z+gqd5nnI=;
        b=YL3UblTNHF7aVS2SJhpSXZIc7lLv3uYkgIcmfrvx205x4wL8t7M4JuLNHgsfcT+w1F
         EJdnnLa3CdCgaVmI3GxNdgNe/gud1m/p5AwDoQXWsDqT5Ejhqh5heIegV3z4vhI0o42E
         /Gc3mi8FQtyTXfkOiZA4ZKdXIc4o/c+73qJlxQ3wmLUYdy0lYV/n0E2jRhboAh9rjtCU
         w/+QCaoIidnqRvtQIZQcJ/DhfykGfABDLWtHSfYimaniBSPWgmT8uVwjqytE0e9Ux9nk
         9uKnovVka/4wt1txoV+8AgCZbqYLMkyrkSY7xdmMLwIBdig4Nbiy5OmwXcuN0/MWoVfs
         Zd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=c3IEd/ZvFvmNljGfIKQJSRIYXpfUeaIdE9z+gqd5nnI=;
        b=kG9VmeE5/9qbx/eiTMpvCDVLx2oQ0F2c3YazZZQ3pxJGbYWDlnznFYJmCCCwVWje8y
         23Od7gKCqMUNWZ6jH0emlQsmrtwch32rofHwVAz6mQ7iBdCjuUn3K96QE1+jn6VV5Qec
         Iu/h+cFPnY44oInKZY8WquUK5qNvUcPZKhoBVZOkl5QXfblz9v0e86Bd5r88t/YmLpCU
         eoakC6D7ow73MVpVhdQWYSsYmiw2toEw0M1JGtzQ5HD2Shc/6qYuykpa0AzAHlCPqSp8
         8zAXBeH0PV9yTKkQhswrBqOwLLVcnipyyeZOhX0ojfH95mn/5efgn7RoeE3dZSaSrs9Y
         NeXQ==
X-Gm-Message-State: AOPr4FXoZJYDAiN7fNp+PpFN+dWfXIqD6sqLxoqDdj9FqoCCVnMJY4jrb2xPOHMXL8gJ9CPv653Kxrr30kLf4A==
X-Received: by 10.107.132.66 with SMTP id g63mr24313310iod.34.1463458799345;
 Mon, 16 May 2016 21:19:59 -0700 (PDT)
Received: by 10.79.139.135 with HTTP; Mon, 16 May 2016 21:19:59 -0700 (PDT)
In-Reply-To: <20160516210545.6591-10-gitster@pobox.com>
X-Google-Sender-Auth: gkanTwMXwUF9pNaxqbbWbADj9QI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294853>

On Mon, May 16, 2016 at 5:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> A common pattern to check N attributes for many paths is to
>
>  (1) prepare an array A of N git_attr_check_elem items;
>  (2) call git_attr() to intern the N attribute names and fill A;
>  (3) repeatedly call git_check_attrs() for path with N and A;
> [...snip...]
> Introduce "struct git_attr_check" that contains N, the number of
> attributes being sought, and A, the array that holds N
> git_attr_check_elem items, and a function git_check_attr() that
> takes a path P and this structure as its parameters.  This structure
> can later be extended to hold extra data necessary for optimization.
>
> Also, to make it easier to write the first two steps in common
> cases, introduce git_attr_check_initl() helper function, which takes
> a NULL-terminated list of attribute names and initialize this
> structure.
> [...snip...]
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/attr.c b/attr.c
> @@ -825,3 +825,37 @@ void git_attr_set_direction(enum git_attr_direction new, struct index_state *ist
> +struct git_attr_check *git_attr_check_initl(const char *one, ...)
> +{
> +       [...]
> +       check = xcalloc(1,
> +                       sizeof(*check) + cnt * sizeof(*(check->check)));
> +       check->check_nr = cnt;
> +       check->check = (struct git_attr_check_elem *)(check + 1);
> +       [...]
> +       return check;
> +}
> diff --git a/attr.h b/attr.h
> @@ -29,6 +29,15 @@ struct git_attr_check_elem {
> +struct git_attr_check {
> +       int check_nr;
> +       int check_alloc;

This field is unused, and git_attr_check_initl() neglects to
initialize it (if it is intended to be used in the future).

> +       struct git_attr_check_elem *check;
> +};
