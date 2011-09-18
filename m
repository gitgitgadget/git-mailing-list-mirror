From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: [PATCH 3/3] fast-import: rename object_count to pack_object_count
Date: Mon, 19 Sep 2011 01:51:27 +0600
Message-ID: <CA+gfSn8aOWPm=xmTE9WzuXsQY0EfYypFxRAyVb-x3_kmhNUb-Q@mail.gmail.com>
References: <1316372508-7173-1-git-send-email-divanorama@gmail.com>
	<1316372508-7173-4-git-send-email-divanorama@gmail.com>
	<20110918193205.GF2308@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 18 21:51:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5NOn-0001RE-AS
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 21:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409Ab1IRTv3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Sep 2011 15:51:29 -0400
Received: from mail-qw0-f42.google.com ([209.85.216.42]:33089 "EHLO
	mail-qw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932273Ab1IRTv2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Sep 2011 15:51:28 -0400
Received: by qwi4 with SMTP id 4so12522849qwi.1
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 12:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=doxqtQFrBKcxHrj1HTllXkkee+6XNWooxulcl4eNWjY=;
        b=yGGKl5RoP4tQTYOwKuguuk02qyjhFcwNGmpEBmxLyERBdojSAry5iUNx69LlIu7Rmc
         oz3vOJcKQNfZTjFnagMyusEzDR8YMkbiRL4cAYtZXITW7gpOn0zvqODAlUWUjyEKM4GM
         3aknhuSt6qoxovj497uJY2Yq6C53pEC7nVTYE=
Received: by 10.229.69.206 with SMTP id a14mr1357336qcj.54.1316375487602; Sun,
 18 Sep 2011 12:51:27 -0700 (PDT)
Received: by 10.229.224.17 with HTTP; Sun, 18 Sep 2011 12:51:27 -0700 (PDT)
In-Reply-To: <20110918193205.GF2308@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181632>

On Mon, Sep 19, 2011 at 1:32 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Dmitry Ivankov wrote:
>
>> object_count is used to count objects that'll go to the current pack=
=2E
>> While object_count_by_* are used to count total amount of objects an=
d
>> are not used to determine if current packfile is empty.
>>
>> Rename (and move declaration) object_count to pack_object_count to
>> avoid possible confusion.
>
> No strong opinion on this one. =A0I guess the important thing is that
> you are moving the declaration to the group of declarations labelled =
as
>
> =A0 =A0 =A0 =A0/* The .pack file being generated */
>
> . =A0Is it important to rename the variable while at it (which will
> disrupt other patches in flight using that variable if they exist)?
Not that important. Maybe a huge comment will do more and better.
object_count++ still appears near object_count_by_type[type]++, but
hopefully one will look for their declarations and thus avoid the confu=
sion.

--- a/fast-import.c
+++ b/fast-import.c
@@ -290,7 +290,6 @@ static uintmax_t object_count_by_type[1 << TYPE_BIT=
S];
 static uintmax_t duplicate_count_by_type[1 << TYPE_BITS];
 static uintmax_t delta_count_by_type[1 << TYPE_BITS];
 static uintmax_t delta_count_attempts_by_type[1 << TYPE_BITS];
-static unsigned long object_count;
 static unsigned long branch_count;
 static unsigned long branch_load_count;
 static int failure;
@@ -310,8 +309,16 @@ static unsigned int atom_cnt;
 static struct atom_str **atom_table;

 /* The .pack file being generated */
+/*
+ * objects that are being written to the current pack
+ * all *must* have current pack_id in struct object_entry.
+ * And object_count *must* be a count of object_entry's
+ * having current pack_id. This data is used to create
+ * index file once current pack_file is finished.
+ */
 static struct pack_idx_option pack_idx_opts;
 static unsigned int pack_id;
+static unsigned long object_count;
 static struct sha1file *pack_file;
 static struct packed_git *pack_data;
 static struct packed_git **all_packs;
