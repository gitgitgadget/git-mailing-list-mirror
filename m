From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 18:00:19 +0200
Message-ID: <BANLkTim90XOLRBPtVCXFb1ptkmUvHGRqeg@mail.gmail.com>
References: <20110428062717.GA952@elte.hu> <BANLkTik_2sHZ0OTgQeHpRnpmNsAmT=sAcA@mail.gmail.com>
 <20110428093703.GB15349@elte.hu> <BANLkTim+Kk_ah_4+pQKCi8bXtA8thRVRjQ@mail.gmail.com>
 <4DB93D16.4000603@cs.helsinki.fi> <BANLkTimD7KZz4fS0QynPui7-JQS10AkLtg@mail.gmail.com>
 <4DB941CD.2050403@cs.helsinki.fi> <BANLkTik-uk-mpdHZxcz8Nem=nEzED_tuJg@mail.gmail.com>
 <20110428123617.GA2062@elie> <20110428133708.GA31383@elte.hu> <20110428151409.GA32025@elte.hu>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Pekka Enberg <penberg@cs.helsinki.fi>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	=?ISO-8859-1?Q?Fr=E9d=E9ric_Weisbecker?= <fweisbec@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Thu Apr 28 18:00:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFTe2-0006TQ-NY
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 18:00:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760416Ab1D1QAl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Apr 2011 12:00:41 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:60970 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757715Ab1D1QAk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2011 12:00:40 -0400
Received: by pxi2 with SMTP id 2so139288pxi.10
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 09:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=HO2e2j+QjYIzgJFwqUWs56LCGbMlN8Zms8USUPUVHeo=;
        b=mjtoREsJGPye7idaTtSnKg1DJldRx+ambZtEfY4qoclm1ebg7Lvm1a5OOhNaMS10A7
         9+Mq1SI0RBMTzYMAezETgHhEsqHmOBxHo7xuTkxBDkPxYiSZ8fb3f7MuU70amCFQvy8J
         Ue4O6a2GJmWkpBMU1h7AgkNV5exNanCPENUDw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=U2KUstwKaesovY40NqnQRQXdMccgzoElcFBBsmnT3rw/zlbCzefmnb3qIWd+PN+gcT
         1VW84AnCHveb0T8iipxowdd/FW7yQ2UHDdyeE5d111Iye44vHWYHv+BQdjwrSh0n73yc
         6VSNZUF1pQm3TWLlHunUXSogRHek2mhS4ETfU=
Received: by 10.68.51.98 with SMTP id j2mr3685139pbo.288.1304006439174; Thu,
 28 Apr 2011 09:00:39 -0700 (PDT)
Received: by 10.68.46.5 with HTTP; Thu, 28 Apr 2011 09:00:19 -0700 (PDT)
In-Reply-To: <20110428151409.GA32025@elte.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172368>

On Thu, Apr 28, 2011 at 5:14 PM, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Ingo Molnar <mingo@elte.hu> wrote:
>
>> * Jonathan Nieder <jrnieder@gmail.com> wrote:
>>
>> > Hi,
>> >
>> > A side note for amusement.
>> >
>> > Erik Faye-Lund wrote:
>> >
>> > > --- a/cache.h
>> > > +++ b/cache.h
>> > > @@ -681,13 +681,17 @@ extern char *sha1_pack_name(const unsigned=
 char *sha1);
>> > > =A0extern char *sha1_pack_index_name(const unsigned char *sha1);
>> > > =A0extern const char *find_unique_abbrev(const unsigned char *sh=
a1, int);
>> > > =A0extern const unsigned char null_sha1[20];
>> > > -static inline int is_null_sha1(const unsigned char *sha1)
>> > > +static inline int hashcmp(const unsigned char *sha1, const unsi=
gned char *sha2)
>> > > =A0{
>> > > - return !memcmp(sha1, null_sha1, 20);
>> > > + /* early out for fast mis-match */
>> > > + if (*sha1 !=3D *sha2)
>> > > + =A0 =A0 =A0 =A0 return *sha1 - *sha2;
>> > > +
>> > > + return memcmp(sha1 + 1, sha2 + 1, 19);
>> > > =A0}
>> >
>> > On the off-chance that sha1 and sha2 are nicely aligned, a more
>> > redundant
>> >
>> > =A0 =A0 if (*sha1 !=3D *sha2)
>> > =A0 =A0 =A0 =A0 =A0 =A0 return *sha1 - *sha2;
>> >
>> > =A0 =A0 return memcmp(sha1, sha2, 20);
>> >
>> > would take advantage of that (yes, this is just superstition, but =
it
>> > somehow seems comforting anyway).
>>
>> Your variant also makes the code slightly more compact as the sha1+1=
 and sha2+1
>> addresses do not have to be computed. I'll re-test and resend this v=
ariant.
>
> Seems to perform measurably worse:
>
> =A0#
> =A0# Open-coded loop:
> =A0#
> =A0Performance counter stats for './git gc' (10 runs):
>
> =A0 =A0 =A0 2358.560100 task-clock =A0 =A0 =A0 =A0 =A0 =A0 =A0 # =A0 =
=A00.763 CPUs utilized =A0 =A0 =A0 =A0 =A0 =A0( +- =A00.06% )
> =A0 =A0 =A0 =A0 =A0 =A0 1,870 context-switches =A0 =A0 =A0 =A0 # =A0 =
=A00.001 M/sec =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0( +- =A03.09% )
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 170 CPU-migrations =A0 =A0 =A0 =A0 =A0 # =
=A0 =A00.000 M/sec =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0( +- =A03.54%=
 )
> =A0 =A0 =A0 =A0 =A0 =A038,230 page-faults =A0 =A0 =A0 =A0 =A0 =A0 =A0=
# =A0 =A00.016 M/sec =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0( +- =A00.0=
3% )
> =A0 =A0 7,513,529,543 cycles =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # =A0=
 =A03.186 GHz =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0( +- =A00.06% =
)
> =A0 =A0 1,634,103,128 stalled-cycles =A0 =A0 =A0 =A0 =A0 # =A0 21.75%=
 of all cycles are idle =A0 ( +- =A00.28% )
> =A0 =A011,068,971,207 instructions =A0 =A0 =A0 =A0 =A0 =A0 # =A0 =A01=
=2E47 =A0insns per cycle
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0# =A0 =A00.15 =A0stalled cycles per insn =A0( +- =A00.0=
4% )
> =A0 =A0 2,487,656,519 branches =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # 1054=
=2E735 M/sec =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0( +- =A00.03% )
> =A0 =A0 =A0 =A059,233,604 branch-misses =A0 =A0 =A0 =A0 =A0 =A0# =A0 =
=A02.38% of all branches =A0 =A0 =A0 =A0 =A0( +- =A00.09% )
>
> =A0 =A0 =A0 =A03.092183093 =A0seconds time elapsed =A0( +- =A03.49% )
>
> =A0#
> =A0# Front test + memcmp:
> =A0#
> =A0Performance counter stats for './git gc' (10 runs):
>
> =A0 =A0 =A0 2723.468639 task-clock =A0 =A0 =A0 =A0 =A0 =A0 =A0 # =A0 =
=A00.833 CPUs utilized =A0 =A0 =A0 =A0 =A0 =A0( +- =A00.22% )
> =A0 =A0 =A0 =A0 =A0 =A0 1,751 context-switches =A0 =A0 =A0 =A0 # =A0 =
=A00.001 M/sec =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0( +- =A02.02% )
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 167 CPU-migrations =A0 =A0 =A0 =A0 =A0 # =
=A0 =A00.000 M/sec =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0( +- =A01.23%=
 )
> =A0 =A0 =A0 =A0 =A0 =A038,230 page-faults =A0 =A0 =A0 =A0 =A0 =A0 =A0=
# =A0 =A00.014 M/sec =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0( +- =A00.0=
3% )
> =A0 =A0 8,684,682,538 cycles =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # =A0=
 =A03.189 GHz =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0( +- =A00.21% =
)
> =A0 =A0 2,062,906,208 stalled-cycles =A0 =A0 =A0 =A0 =A0 # =A0 23.75%=
 of all cycles are idle =A0 ( +- =A00.60% )
> =A0 =A0 9,019,624,641 instructions =A0 =A0 =A0 =A0 =A0 =A0 # =A0 =A01=
=2E04 =A0insns per cycle
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0# =A0 =A00.23 =A0stalled cycles per insn =A0( +- =A00.0=
4% )
> =A0 =A0 1,771,179,402 branches =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # =A06=
50.340 M/sec =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0( +- =A00.04% )
> =A0 =A0 =A0 =A075,026,810 branch-misses =A0 =A0 =A0 =A0 =A0 =A0# =A0 =
=A04.24% of all branches =A0 =A0 =A0 =A0 =A0( +- =A00.04% )
>
> =A0 =A0 =A0 =A03.271415104 =A0seconds time elapsed =A0( +- =A01.97% )
>
> So i think the open-coded loop variant i posted is faster.
>
> The key observation is that there's two cases that matter to performa=
nce:
>
> =A0- the hashes are different: in this case the front test catches 99=
% of the cases
> =A0- the hashes are *equal*: in this case the open-coded loop perform=
s better than the memcmp
>
> My patch addresses both cases.
>

Thanks. I also timed on my end (on Windows), and I came to the same
conclusion (but the improvements of your original was somewhat smaller
in my end; could be due to the test-case). It seems like the early-out
wasn't the only reason your original patch performed faster. It could
be that memcmp (probably) didn't get inlined, and the extra function
call outweighs the complexity. Or there's something else going on that
both affects glibc and msvcrt.dll.
