From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: Re: [PATCH/RFC v2 0/16] Introduce index file format version 5
Date: Mon,  6 Aug 2012 21:35:58 +0700
Message-ID: <1344263760-31191-1-git-send-email-pclouds@gmail.com>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, robin.rosenberg@dewire.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 16:37:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyOQs-0001Mb-Eo
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 16:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756605Ab2HFOhK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Aug 2012 10:37:10 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47575 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756269Ab2HFOhI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 10:37:08 -0400
Received: by pbbrr13 with SMTP id rr13so2667860pbb.19
        for <git@vger.kernel.org>; Mon, 06 Aug 2012 07:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=q3gcyJ31Va12dPkdZU6h7UqzqECxXSg1Qpt6Om/jQis=;
        b=WqWw4l5abjKEiBTJiQWfVwud7e6ox90jZDkP968Q01xq4dcNcmSrGmWGksoB8HUKpr
         um/7J/zh05Y9MJkldx0pIEfhkP6BV+lfkirkQascJBO2ftRZP/QsV9Tb93o3/yfGYp/B
         z0ydJXY7htyjGDMmX12WIii7Jf/2gTPwHvMa5a/+p7JO1CDNNjVwK4ZB3GAYOVzFTiNt
         Qd/hoBNjr9f1vyYgwOy/bsx/pXvxzwg2v03Cwrt8YbgAs8ZY7gROmwNITqDB+bUwgO2V
         scUqx4MR/vfaNfuVvUvJ4yP9CZtbrxv0gY6l4Kb3xc7CxY/RXoph/d7eSnU5yZbHKpGI
         dVlg==
Received: by 10.68.134.161 with SMTP id pl1mr19386481pbb.29.1344263828180;
        Mon, 06 Aug 2012 07:37:08 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.55.147])
        by mx.google.com with ESMTPS id wi6sm5652820pbc.35.2012.08.06.07.37.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 06 Aug 2012 07:37:07 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 06 Aug 2012 21:36:02 +0700
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202964>

These mails are about cosmetics only. But I think it helps maintenance
in long term. I notice in your series we have many functions with _v2
and _v5 mixed together. Worse, some functions that are _v2 only are
not suffixed with _v2. I still think separating v2/v5 changes is a
good idea. So I played a bit, see how it might become.

The next two emails demonstrate how we take v2-specific code out to
read-cache-v2.c, then add v5 code in the next patch. Notice there's ver=
y
little change in read-cache.c in the second patch. I wanted to see how
v5 changes affects v2 users and the second patch shows it.

I'm not happy with the first patch either. Ideally it should consist
of code move only, no other changes. All updates in read_index_from
and the introduction of struct index_ops should happen in patches
before that.

Then of course you need to split the second patch into several logical
patches again. We can drop _v5 suffix in read-cache-v5.c (I haven't
done that). When we add partial read/write for v5, we can add more
func pointers to index_ops and implement them in v2 (probably as no-op
or assertion)

There are still some v5 bits in the first patch. This series is not
meant to be used anyway, so it does not matter much. Hope it helps.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
  Move index v2 specific code out of read-cache
  Add index-v5

 Makefile        |    3 +
 cache.h         |   92 ++++-
 read-cache-v2.c |  570 +++++++++++++++++++++++++++
 read-cache-v5.c | 1170 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 read-cache.c    |  618 +++---------------------------
 read-cache.h    |   54 +++
 6 files changed, 1932 insertions(+), 575 deletions(-)
 create mode 100644 read-cache-v2.c
 create mode 100644 read-cache-v5.c
 create mode 100644 read-cache.h

--=20
1.7.8
