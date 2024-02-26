Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2334E12FF6E
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 19:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974191; cv=none; b=Vl5LtAi+4Kx5jT093PLl/OsHTWyMVoT4k3GeTTlPwa5aBBimFUxmU7/foj01dtGLiDlAF21x3tOoZPrMs7p7sj2IBUz62TVliqafVaEvIP1d7qa48Kv70fi3ZJyM75Ogyno+5rm6I8lqHwH1O1OiPQq16N5hFOUJCm+wkex92Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974191; c=relaxed/simple;
	bh=IQ2lklV/bX7QCz7/QViZxtXb0r+Sz7GFO+RMuXKPLrs=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=faJoMSaUsNULjYfVhGWwWfK4Wl5NJ16p60AbtauclIOE8ZHYuj87VA7kBL0BO1y4Jwqhq9fc64FqXJENtaUS2/sNK14vl2FlDQF15qKdDm5KVYrz/ckytwj97hQnEFjARi8dFIuZQVZFfkXYHwgwyTFusJ4Hn3dKYgbvnOzCt28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 41QJ2t6D2192674
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 19:02:55 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <phillip.wood@dunelm.org.uk>,
        "=?utf-8?Q?'Torsten_B=C3=B6gershausen'?=" <tboegi@web.de>
Cc: <git@vger.kernel.org>, "'Patrick Steinhardt'" <ps@pks.im>
References: <01bd01da681a$b8d70a70$2a851f50$@nexbridge.com> <01be01da681e$0c349090$249db1b0$@nexbridge.com> <20240225191954.GA28646@tb-raspi4> <01ca01da682a$5f6a7b60$1e3f7220$@nexbridge.com> <5e807c1c-20a0-407b-9fc2-acd38521ba45@gmail.com> <76962a0c-adfd-47a5-a017-a117ba14ae09@gmail.com>
In-Reply-To: <76962a0c-adfd-47a5-a017-a117ba14ae09@gmail.com>
Subject: RE: [BUG] 2.44.0 t7704.9 Fails on NonStop ia64
Date: Mon, 26 Feb 2024 14:02:50 -0500
Organization: Nexbridge Inc.
Message-ID: <025301da68e6$68956940$39c03bc0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQH6KeHXK3ktIx6cNmAt1sL267+NoQLej1jbAXwNbRICuPECnQG1wVidAfcdzTGwh3TnUA==

On Monday, February 26, 2024 11:00 AM, Phillip Wood wrote:
>On 26/02/2024 15:32, Phillip Wood wrote:
>> Hi Randal
>>
>> [cc'ing Patrick for the reftable writer]
>>
>> On 25/02/2024 20:36, rsbecker@nexbridge.com wrote:
>>> On Sunday, February 25, 2024 2:20 PM, Torsten B=C3=B6gershausen =
wrote:
>>>> On Sun, Feb 25, 2024 at 02:08:35PM -0500, rsbecker@nexbridge.com =
wrote:
>>>>> On Sunday, February 25, 2024 1:45 PM, I wrote:
>>>>>> To: git@vger.kernel.org
>>>> But I think that this should be used:
>>>> write_in_full()
>>>
>>> My mailer autocorrected, yes, xwrite. write_in_full() would be safe,
>>> although a bit redundant since xwrite() does similar things and is
>>> used by write_in_full().
>>
>> Note that unlike write_in_full(), xwrite() does not guarantee to =
write
>> the whole buffer passed to it. In general unless a caller is writing =
a
>> single byte or writing less than PIPE_BUF bytes to a pipe it should
>> use write_in_full().
>>
>>> The question is which call is bad? The cruft stuff is relatively new
>>> and I don't know the code.
>
>I should have been clearer that I do not think any of these calls are =
the likely
>problem for the cruft pack code. I do think the reftable writers are =
worth looking at
>though for git in general.
>
>For the cruft pack problem you might want to look for suspect xwrite() =
calls where
>the caller does not handle a short write correctly for example under =
builtin/ we have
>
>builtin/index-pack.c:                   err =3D xwrite(1, input_buffer =
+
>input_offset, input_len);
>builtin/receive-pack.c:         xwrite(2, msg, sz);
>builtin/repack.c:       xwrite(cmd->in, oid_to_hex(oid),
>the_hash_algo->hexsz);
>builtin/repack.c:       xwrite(cmd->in, "\n", 1);
>builtin/unpack-objects.c:               int ret =3D xwrite(1, buffer +
>offset, len);
>
>Best Wishes
>
>Phillip
>
>>>>> reftable/writer.c:              int n =3D w->write(w->write_arg,
>>>>> zeroed,
>>>>> w->pending_padding);
>>>>> reftable/writer.c:      n =3D w->write(w->write_arg, data, len);
>>
>> Neither of these appear to check for short writes and
>> reftable_fd_write() is a thin wrapper around write(). Maybe
>> reftable_fd_write() should be using write_in_full()?
>>
>>>>> run-command.c:                  len =3D write(io->fd, =
io->u.out.buf,
>>
>> This call to write() looks correct as it is in the io pump loop.
>>
>>>>> t/helper/test-path-utils.c:                     if (write(1,
>>>>> buffer,
>>> count)
>>>>> < 0) >>> t/helper/test-windows-named-pipe.c:             write(1,
>>>>> buf, nbr);
>>>>> t/helper/test-windows-named-pipe.c:             write(1, buf, =
nbr);
>>
>> In principle these all look like they are prone to short writes.
>>
>>>>> trace2/tr2_dst.c:       bytes =3D write(fd, buf_line->buf,
>>>>> buf_line->len);
>>
>> This caller explicitly says it prefers short writes over retrying

Replacing xwrite with write_in_full  the above worked correctly. Do you =
want it or should I write this up?

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index a3a37bd215..f80b8d101a 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1571,7 +1571,7 @@ static void final(const char *final_pack_name, =
const char *curr_pack_name,
                 * the last part of the input buffer to stdout.
                 */
                while (input_len) {
-                       err =3D xwrite(1, input_buffer + input_offset, =
input_len);
+                       err =3D write_in_full(1, input_buffer + =
input_offset, input_len);
                        if (err <=3D 0)
                                break;
                        input_len -=3D err;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index db65607485..4277c63d08 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -456,7 +456,7 @@ static void report_message(const char *prefix, const =
char *err, va_list params)
        if (use_sideband)
                send_sideband(1, 2, msg, sz, use_sideband);
        else
-               xwrite(2, msg, sz);
+               write_in_full(2, msg, sz);
 }

 __attribute__((format (printf, 1, 2)))
diff --git a/builtin/repack.c b/builtin/repack.c
index ede36328a3..4916870992 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -314,8 +314,8 @@ static int write_oid(const struct object_id *oid,
                        die(_("could not start pack-objects to repack =
promisor objects"));
        }

-       xwrite(cmd->in, oid_to_hex(oid), the_hash_algo->hexsz);
-       xwrite(cmd->in, "\n", 1);
+       write_in_full(cmd->in, oid_to_hex(oid), the_hash_algo->hexsz);
+       write_in_full(cmd->in, "\n", 1);
        return 0;
 }

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index e0a701f2b3..6935c4574e 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -680,7 +680,7 @@ int cmd_unpack_objects(int argc, const char **argv, =
const char *prefix UNUSED)

        /* Write the last part of the buffer to stdout */
        while (len) {
-               int ret =3D xwrite(1, buffer + offset, len);
+               int ret =3D write_in_full(1, buffer + offset, len);
                if (ret <=3D 0)
                        break;
                len -=3D ret;


