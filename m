From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 08/11] pack-objects: create pack v4 tables
Date: Mon, 9 Sep 2013 17:40:45 +0700
Message-ID: <CACsJy8DbMnr9Y8NyGTNd6r8hSg3zbgaLa1h-e1X7FFVHHahwpg@mail.gmail.com>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
 <1378652660-6731-1-git-send-email-pclouds@gmail.com> <1378652660-6731-9-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Sep 09 12:41:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIyuH-0006wV-29
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 12:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811Ab3IIKlQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Sep 2013 06:41:16 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:42519 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252Ab3IIKlP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Sep 2013 06:41:15 -0400
Received: by mail-oa0-f49.google.com with SMTP id i7so6263405oag.22
        for <git@vger.kernel.org>; Mon, 09 Sep 2013 03:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=cGI4GNkNNgQE0N/lcie1q3GdY3cNl6lxOgP9bWwU9+U=;
        b=iV4j2uAPCK50DdQYwUyv65Zzr7w3dZZTH24f5TcjasNlJE7bZhB0LhYQey3pAU1SMa
         3qoD/+8wThAcXDW7wN+4fvSjuFyKTu/eFOelO/NRTtQBE+gTq7RupIEG4eycPf8TMcYK
         IDiWKQMzG6VjqtA9EujwsNVHL4R9QafaV0HRCpyZJCT2tmYrRJJktMQTCjGEjqSoXqzt
         DJA5U/TpzYPYdQdqRm1VCYlRzhaozsbnVUHc/jErKv9NhgQQxTzSh5bJVPbiul6Ft+NR
         MwJGzFHRrCFnWhk4xh6leuLb4OB5jJ8nq/G0vi7yhMKhhQLtZGk3HOKmWifkqZoqOz+S
         j4Sg==
X-Received: by 10.182.98.162 with SMTP id ej2mr10930767obb.61.1378723275391;
 Mon, 09 Sep 2013 03:41:15 -0700 (PDT)
Received: by 10.182.49.233 with HTTP; Mon, 9 Sep 2013 03:40:45 -0700 (PDT)
In-Reply-To: <1378652660-6731-9-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234322>

On Sun, Sep 8, 2013 at 10:04 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> +static void prepare_sha1_table(void)
> +{
> +       unsigned i;
> +       /*
> +        * This table includes SHA-1s that may not be present in the
> +        * pack. One of the use of such SHA-1 is for completing thin
> +        * packs, where index-pack does not need to add SHA-1 to the
> +        * table at completion time.
> +        */
> +       v4.all_objs =3D xmalloc(nr_objects * sizeof(*v4.all_objs));
> +       v4.all_objs_nr =3D nr_objects;
> +       for (i =3D 0; i < nr_objects; i++)
> +               v4.all_objs[i] =3D objects[i].idx;
> +       qsort(v4.all_objs, nr_objects, sizeof(*v4.all_objs),
> +             sha1_idx_sort);
> +}
> +

fwiw this is wrong. Even in the non-thin pack case, pack-objects could
write multiple packs to disk and we need different sha-1 table for
each one. The situation is worse for thin pack because not all
preferred_base entries end up a real dependency in the final pack. I'm
working on it..
--=20
Duy
