From: Allan Caffee <allan.caffee@gmail.com>
Subject: Re: [PATCH] describe: Refresh the index when run with --dirty
Date: Tue, 2 Aug 2011 18:38:08 -0400
Message-ID: <CA+jCPNeQ-ry9Cq2fL8sbnnuzBQO4MP=VkXrXTJT3H9zSFtQYSw@mail.gmail.com>
References: <20110731062055.GB14384@sigill.intra.peff.net>
	<1312163561-77072-1-git-send-email-allan.caffee@gmail.com>
	<7v1ux3eapk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 03 00:38:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoNbL-0004qc-DR
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 00:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752298Ab1HBWiL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Aug 2011 18:38:11 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39672 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993Ab1HBWiJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Aug 2011 18:38:09 -0400
Received: by iyb12 with SMTP id 12so254584iyb.19
        for <git@vger.kernel.org>; Tue, 02 Aug 2011 15:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=b8m+sx5AjEw3Nrr+5xmj5q6g60LXzl0ceEMudrgDecs=;
        b=NJjZahEehv5UWUrOpmIepozShtZU9tKullirh8Mc8LxEF76M02LVO83birH5rBnGy9
         24pG4KbEnqCpYi5SlhifXzzB0twwkjycqktvbbLHKhQLJEg0IbIJEl8TV93PAsilN63s
         cNDPLO+B2cO1qdkan0Iv4l+lD8HBnRPJc5Ql4=
Received: by 10.42.117.7 with SMTP id r7mr3413557icq.147.1312324688989; Tue,
 02 Aug 2011 15:38:08 -0700 (PDT)
Received: by 10.231.206.20 with HTTP; Tue, 2 Aug 2011 15:38:08 -0700 (PDT)
In-Reply-To: <7v1ux3eapk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178529>

On Tue, Aug 2, 2011 at 5:59 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Thanks.
>
> Here is a minor fix-up on top, that can be squashed in a re-roll (if =
you
> plan to do one).

Thanks for the patch.  I'll squash this into v2.

On Sun, Jul 31, 2011 at 11:51 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Jul 31, 2011 at 09:52:41PM -0400, Allan Caffee wrote:
>
>> When running git describe --dirty the index should be refreshed. =A0=
Previously
>> the cached index would cause describe to think that the index was di=
rty when,
>> in reality, it was just stale.
>>
>> The issue was exposed by python setuptools which hardlinks files int=
o another
>> directory when building a distribution.
>
> Overall, looks good to me. A few minor nits, though:
>
>> diff --git a/builtin/describe.c b/builtin/describe.c
>> index 66fc291..792af76 100644
>> --- a/builtin/describe.c
>> +++ b/builtin/describe.c
>> @@ -24,6 +24,7 @@ static int longformat;
>> =A0static int abbrev =3D -1; /* unspecified */
>> =A0static int max_candidates =3D 10;
>> =A0static struct hash_table names;
>> +static struct lock_file index_lock; /* real index */
>
> This line was presumably copied straight from builtin/commit.c. You c=
an
> drop the "real index" comment here. Commit may deal with multiple
> indices, which is what this comment was clarifying, but here it doesn=
't
> make any sense.
>
>> =A0static int always;
>> @@ -399,6 +400,7 @@ static void describe(const char *arg, int last_o=
ne)
>> =A0int cmd_describe(int argc, const char **argv, const char *prefix)
>> =A0{
>> =A0 =A0 =A0 int contains =3D 0;
>> + =A0 =A0 int fd;
>
> If a variable is only going to be used for one deep conditional, IMHO
> it's nice to declare it inside the conditional block, so readers of t=
he
> code don't have to wonder under what conditions fd is valid.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (dirty) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 read_cache();
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 refresh_index(&the_index, =
REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL, NULL);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fd =3D hold_locked_index(&=
index_lock, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (0 <=3D fd)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 update_ind=
ex_if_able(&the_index, &index_lock);
>
> A few questions about this read_cache call:
>
> =A01. Should this actually be:
>
> =A0 =A0 =A0 =A0 =A0if (read_cache() < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die("unable to read cache");
>
> =A0 =A0 ? I notice that cmd_status also does not check the error code=
=2E But
> =A0 =A0 it seems like if we fail to read, we would then potentially w=
rite
> =A0 =A0 out a bogus index. Probably unlikely, as failure to read prob=
ably
> =A0 =A0 implies failure to write.

It definitely seems like writing out a bogus index would be bad, but
even if both the read *and* the write fail we would still be
potentially mislabeling it as "dirty" if we failed to it in the first
place.  It seems like, since they explicitly requested --dirty, we
ought to give up here since we can't accurately respond.

> =A02. Should the read and refresh happen while we hold the lock?
> =A0 =A0 Otherwise our read-modify-update is not atomic, and we risk
> =A0 =A0 overwriting another index writer. Again, cmd_status suffers f=
rom
> =A0 =A0 the same problem, so this is not something you are introducin=
g.

Yeah it definitely is a race condition as far as I can tell.  Should
this be changed in cmd_status (builtin/commit.c:1227-1232) as well?

--
Allan
