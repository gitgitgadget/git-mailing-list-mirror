From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 00/21] np/pack-v4 updates
Date: Thu, 12 Sep 2013 10:38:49 +0700
Message-ID: <CACsJy8B7WAz4eB88gJCWc3Z0fpSrop8f_Xex1tkmykYuSYUFUQ@mail.gmail.com>
References: <xmqqtxhswexg.fsf@gitster.dls.corp.google.com> <1378879582-15372-1-git-send-email-pclouds@gmail.com>
 <CACsJy8C87k7K6dnr5N_mqz9w7YtdHzjB+jPwrwtMk1oeXxWYGQ@mail.gmail.com> <alpine.LFD.2.03.1309111224460.20709@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Sep 12 05:39:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJxka-0006ht-Hl
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 05:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118Ab3ILDjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 23:39:20 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:46422 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392Ab3ILDjU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 23:39:20 -0400
Received: by mail-pb0-f53.google.com with SMTP id up15so9931410pbc.40
        for <git@vger.kernel.org>; Wed, 11 Sep 2013 20:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WZaHUdC67apfZ3LCHohwKvVXPgJ3VK31Xruq9rZP8Bc=;
        b=xJevn6iU5XBQGMU1tJyNw/vEbVpB2Fb5GXraDXF0IOosWxZD0iiiHx2/aOU3Mnxrkb
         3ACsbsbSDJSxmioOIE8Gzu8kvvNcbxYQacmptawYzeBKz0+4iPMt84cN6NgIQyiOLF6G
         BXfTJNCZFeeqH2W7eLhVa8tY/bmYVaqJ2oONLpedBeiqz2AElx4xuGaxXJOjkc3EGXHL
         4myfK/H1vtlFcgImF0BtIW+wNsdJc6iTWsiWkAKcHEwx3O9M9h5oWeY0ThsjdVXRNNVd
         yo95b/ooOtIYRgGZQYOMNTGNp8HnlNTbFKKWPLKu2EkdXGFhRp0gGh6peD9VKOk+Jsf9
         QcDQ==
X-Received: by 10.68.64.201 with SMTP id q9mr5347400pbs.15.1378957159527; Wed,
 11 Sep 2013 20:39:19 -0700 (PDT)
Received: by 10.70.131.167 with HTTP; Wed, 11 Sep 2013 20:38:49 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.03.1309111224460.20709@syhkavp.arg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234617>

On Wed, Sep 11, 2013 at 11:25 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Wed, 11 Sep 2013, Duy Nguyen wrote:
>
>> Nico, if you have time you may want to look into this. The result v4
>> pack from pack-objects on git.git for me is 35MB (one branch) while
>> packv4-create produces 30MB (v2 is 40MB). I don't know why there is
>> such a big difference in size. I compared. Ident dict is identical.
>> Tree dict is a bit different (some that have same hits are ordered
>> differently). Delta chains do not differ much. Many groups of entries
>> in the pack are displaced though. I guess I turned a wrong knob or
>> something in pack-objects in v4 code..
>
> Will try to have a closer look.

Problem found. I encoded some trees as ref-delta instead of pv4-tree
:( Something like this brings the size back to packv4-create output

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f604fa5..3d9ab0e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1490,7 +1490,8 @@ static void check_object(struct object_entry *entry)
  * deltify other objects against, in order to avoid
  * circular deltas.
  */
- entry->type = entry->in_pack_type;
+ if (pack_version < 4)
+ entry->type = entry->in_pack_type;
  entry->delta = base_entry;
  entry->delta_size = entry->size;
  entry->delta_sibling = base_entry->delta_child;
-- 
Duy
