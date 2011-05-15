From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCHv3 4/9] pack-objects: Teach new option --max-object-count,
 similar to --max-pack-size
Date: Sun, 15 May 2011 16:48:11 -0700
Message-ID: <BANLkTi=zB=6eVHdG8N5LLDVx=1hK0tSNGQ@mail.gmail.com>
References: <201105151942.29219.johan@herland.net> <1305495440-30836-5-git-send-email-johan@herland.net>
 <BANLkTi=qtA=34=pdXuJ_cQu0pv6BnE2uSA@mail.gmail.com> <201105160031.15339.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 16 01:48:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLl38-0001A8-1p
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 01:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154Ab1EOXsc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 May 2011 19:48:32 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:55610 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950Ab1EOXsb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2011 19:48:31 -0400
Received: by vxi39 with SMTP id 39so2819425vxi.19
        for <git@vger.kernel.org>; Sun, 15 May 2011 16:48:31 -0700 (PDT)
Received: by 10.52.108.194 with SMTP id hm2mr5050474vdb.233.1305503311077;
 Sun, 15 May 2011 16:48:31 -0700 (PDT)
Received: by 10.52.157.73 with HTTP; Sun, 15 May 2011 16:48:11 -0700 (PDT)
In-Reply-To: <201105160031.15339.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173682>

On Sun, May 15, 2011 at 15:31, Johan Herland <johan@herland.net> wrote:
> On Monday 16 May 2011, Shawn Pearce wrote:
>> On Sun, May 15, 2011 at 14:37, Johan Herland <johan@herland.net> wro=
te:
>> > The new --max-object-count option behaves similarly to --max-pack-=
size,
>> > except that the decision to split packs is determined by the numbe=
r of
>> > objects in the pack, and not by the size of the pack.
>>
>> Like my note about pack size for this case... I think doing this
>> during writing is too late. We should be aborting the counting phase
>> if the output pack is to stdout and we are going to exceed this limi=
t.
>
> The patch actually does this in the --stdout case. Look at the last
> hunk in builtin/pack-objects.c:
>
> @@ -2349,6 +2366,9 @@ int cmd_pack_objects(int argc, const char **arg=
v, const char *prefix)
>
> =A0 =A0 =A0 =A0if (non_empty && !nr_result)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> + =A0 =A0 =A0 if (pack_to_stdout && object_count_limit && object_coun=
t_limit < nr_result)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("unable to make pack within the obj=
ect count limit"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " (%lu objects)", objec=
t_count_limit);
> =A0 =A0 =A0 =A0if (nr_result)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0prepare_pack(window, depth);
> =A0 =A0 =A0 =A0write_pack_file();
>
> So in the --stdout case, we have already aborted before we start
> writing the pack (i.e. after the counting phase).
>
> The commit message you quote above, are for the case where someone us=
es
> --max-object-count _without_ --stdout, in which case we compare
> nr_written to object_count_limit to determine when to split the pack.

Thanks for the clarification. Its Sunday, I am clearly not scanning
patches with the level of detail I should be.  :-)

Given that this block is in here, most of the series looks pretty good
to me. Thanks for following up with this round, I know its a lot more
than you originally wanted to do for this "simple" limit, but I think
its a worthwhile improvement.

--=20
Shawn.
