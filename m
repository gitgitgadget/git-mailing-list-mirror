From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 06/19] ref-filter: implement '--merged' and
 '--no-merged' options
Date: Sun, 21 Jun 2015 18:00:52 -0700
Message-ID: <CAPc5daVtMjv=shHhnnR=_p37ND9-64MV-wrsfQA9p2OQ0DbZUA@mail.gmail.com>
References: <CAOLa=ZS_vn8ZNrb7mtqZKU4Y3RCZojcbeMYfbx=3X-aVjhdpSA@mail.gmail.com>
 <1434919705-4884-1-git-send-email-karthik.188@gmail.com> <1434919705-4884-6-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 03:01:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6q6v-0004MR-Ql
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 03:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753033AbbFVBBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 21:01:14 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:35036 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503AbbFVBBM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2015 21:01:12 -0400
Received: by obbop1 with SMTP id op1so10509674obb.2
        for <git@vger.kernel.org>; Sun, 21 Jun 2015 18:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=x+7tQqr3hfQoo02azAmmOXrnefTob8GmXSEJqHhH02U=;
        b=s+bs0TL11gi/MKTHF+q9SW5qgYyLj//wgvvGTGEsN04MkLWGc3wAdc9+YgBRoGOlUc
         phxc/2dtaPAsBo6FzdGuqOxYd/FMEra45X+RWGBi9D4kKAHo7KfqXApgw6VidsHli3Oh
         aMVX4hUcoFFkr8U9nYva9h32M75TtO7jR1cRJjpGn0dJgWYDRmUsxaRjH7Y5n5hKgrT/
         mcrP9EPn5uwDYrGQDyZJD4PRdjI7FCOehNXoxPBv+7P9u5oX/56JZlotz/W4/DU7sE1H
         C1n6TtEMMWRlvHLbVCDWeIotUIa0rvCdvzEqHdEuEoYkSf8tXRiUJ3d3PFuWsarCLHgI
         +VGQ==
X-Received: by 10.202.98.193 with SMTP id w184mr21450055oib.96.1434934871871;
 Sun, 21 Jun 2015 18:01:11 -0700 (PDT)
Received: by 10.202.202.129 with HTTP; Sun, 21 Jun 2015 18:00:52 -0700 (PDT)
In-Reply-To: <1434919705-4884-6-git-send-email-karthik.188@gmail.com>
X-Google-Sender-Auth: eSGiV7zd9Tu1pTBGEvm9XUwH64A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272312>

On Sun, Jun 21, 2015 at 1:48 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> +static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata)
> +{
> +       struct rev_info revs;
> +       int i, old_nr;
> +       struct ref_filter *filter = ref_cbdata->filter;
> +       struct ref_array *array = ref_cbdata->array;
> +       struct commit_list *p, *to_clear = NULL;
> +
> +       init_revisions(&revs, NULL);
> +
> +       for (i = 0; i < array->nr; i++) {
> +               struct ref_array_item *item = array->items[i];
> +               add_pending_object(&revs, &item->commit->object, item->refname);
> +               commit_list_insert(item->commit, &to_clear);

Use of commit_list for an array of known number of commits feels somewhat
wasteful. Couldn't to_clear be

    struct commit **to_clear = xcalloc(sizeof(struct commit *), array->nr);

instread?
