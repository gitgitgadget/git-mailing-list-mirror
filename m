From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [GSoC update] Sequencer for inclusion
Date: Tue, 12 Jul 2011 12:11:44 +0530
Message-ID: <CALkWK0n41LZ8-ZU2M1oD_ddJ2g2A47MxuO8w+5Ew6Php8gvF+g@mail.gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <20110711171713.GA5963@elie> <7vpqlgbjmd.fsf@alter.siamese.dyndns.org> <20110711221419.GE30155@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Miles Bader <miles@gnu.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 12 08:42:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgWfc-0006N8-QY
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 08:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758056Ab1GLGmG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jul 2011 02:42:06 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:47103 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758042Ab1GLGmF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2011 02:42:05 -0400
Received: by wyg8 with SMTP id 8so3036349wyg.19
        for <git@vger.kernel.org>; Mon, 11 Jul 2011 23:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=+Zt8Q54ITnk4h8zUucsSbg6CVcYMb2eyZJQ7WB0RDBw=;
        b=EgUYzUNDRn5iuSPvfABwqGuH53gaXnQ6V4NgiRer8N7qvnAMKn/0wJmNOUS9y9Q9xi
         diBxklrpQtnbld7YrDzZ6fU+CRhfb6sUU04FiqDmu3gPI+iw5KejidsaLFhd4hdTIhPr
         DrMhZx4jowaYF0bmtkW5DSdkaUFYFKLg9kbhI=
Received: by 10.216.50.2 with SMTP id y2mr4726401web.77.1310452924178; Mon, 11
 Jul 2011 23:42:04 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Mon, 11 Jul 2011 23:41:44 -0700 (PDT)
In-Reply-To: <20110711221419.GE30155@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176932>

Hi Jeff, Junio, Jonathan, and Miles,

Jeff King writes:
> On Mon, Jul 11, 2011 at 01:07:20PM -0700, Junio C Hamano wrote:
>> > To be precise, the format used includes
>> >
>> > =C2=A0 =C2=A0 strategy-option =3D patience | renormalize
>> >
>> > to represent the effect of "-Xpatience -Xrenormalize". =C2=A0My on=
ly worry
>> > about that is that the "|" can sound like "or", which would seem
>> > strange to a user that does not necessarily develop software (so i=
s
>> > not thinking about bitfields). =C2=A0The format used in config fil=
es puts
>> >
>> > =C2=A0 =C2=A0 strategy-option =3D patience
>> > =C2=A0 =C2=A0 strategy-option =3D renormalize
>> >
>> > as separate lines.
>>
>> A very good point again. I do not think anywhere in our codebase we =
use
>> "|" as a separator for state files (either used for internal or expo=
sed to
>> the end user), and we probably would want to be consistent across
>> commands.
>
> I had the same feeling about the "|". I'm a little confused about wha=
t
> these options are good for, though.

Miles Bader writes:
> How about using "+" instead of "|"...?
>
> I think that would make sense both for bitfield-thinking and
> non-bitfield-thinking readers ... :]

=46rankly, I don't like the idea of separate lines like "key =3D value1=
"
and "key =3D value 2" -- even a generic *nix configuration file parser
would break here.  Yes, I know that we don't use "|" anywhere else; we
don't persist options anywhere else either, so I was trying to be
inventive :p

I didn't realize "|" would confuse users -- if that's the case, should
we use a different separator like Miles' "+" suggestion?

Jeff King writes:
> Is it purely about saving some persistent data between runs, and nobo=
dy
> else is going to look at it? In that case, I don't think it matters w=
hat
> the format is. Use some unambiguous encoding that we already have
> available (like sq_quote_argv and sq_dequote_argv), and write as litt=
le
> code as possible.
>
> Or is it something that, like the information in .git/rebase-apply,
> people might want to read or tweak? In that case, might it make sense=
 to
> follow that lead and split things into one file per item? That keeps =
the
> parsing burden extremely low for things like shell scripts (or shell
> users) who might want to read or tweak.

Yes, it's a little like the information in .git/rebase-apply.  We
should give the user the ability to tweak it by hand: the result from
sq_quote_argv and sq_dequote_argv would look very ugly.  Hm, I don't
like the one-file-per-command-line-option approach because: we might
only have a few options now, but when the sequencer is built to
support many actions and options, the directory will be polluted with
lots of files.  I was thinking more along the lines of something that
can be parsed using gitconfig.

Thanks.

-- Ram
