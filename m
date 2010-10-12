From: Chase Brammer <cbrammer@gmail.com>
Subject: Re: Push not writing to standard error
Date: Tue, 12 Oct 2010 14:37:50 -0600
Message-ID: <AANLkTim_pjJ76J0ctSQO=eYsVtkZAgq2nhm0fskjjo+g@mail.gmail.com>
References: <AANLkTim6j7cXj2-1JnKdNLb8KFJK86F02tzeByDBskEa@mail.gmail.com>
	<20101012192117.GD16237@burratino>
	<20101012193204.GA8620@sigill.intra.peff.net>
	<20101012193830.GB8620@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Tay Ray Chuan <rctay89@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 12 22:38:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5lbk-0006l5-Kn
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 22:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758213Ab0JLUhz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Oct 2010 16:37:55 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60257 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757940Ab0JLUhy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Oct 2010 16:37:54 -0400
Received: by wwj40 with SMTP id 40so5568830wwj.1
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 13:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ekXcl22tfVKdTRPQiIIRts2jwDpqPYw1EqUstBi/2Sg=;
        b=FHeFMDTfl6buGsylxALLQkEQr7yM1if5GRVU4c0PEdKgh2HT+UqdAz1i+yEjZHTop1
         TaEsL1VBXn0dnPJxH2f4wSB5uykBA2Uj4EzvrlVzhoeYEXRljENIW540Yo/3oHY2nVhT
         BWvLfpPDRqq18f0k2QsmPnD9INO8X0DkZHiYw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Pv7XIsj7F0NhTFsp4vhEAsTC86rKLy/N27/y1tzZtsr7Z00KlRlx0AyXvmq3Fp8lmJ
         5e4cWNtulL4AZ9r8Kap2CsQS4OwJ6DL5yGX/YhGk0LscAC2xPe6Rj0VrSWOwOnKAqb7o
         W/2az7JuuSV+wXBqPcmVKvNb36CSqgpRDrZoc=
Received: by 10.216.74.82 with SMTP id w60mr321062wed.106.1286915870199; Tue,
 12 Oct 2010 13:37:50 -0700 (PDT)
Received: by 10.216.29.195 with HTTP; Tue, 12 Oct 2010 13:37:50 -0700 (PDT)
In-Reply-To: <20101012193830.GB8620@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158878>

Wow, I am amazed at how quick you churned that out.  I haven't
participated in the git patch and release cycle, so forgive my
ignorance.  Do you think that this will be released in the next
release (1.7.3.2) ? If so, any expectations on release date?

Chase


On Tue, Oct 12, 2010 at 1:38 PM, Jeff King <peff@peff.net> wrote:
>
> On Tue, Oct 12, 2010 at 03:32:04PM -0400, Jeff King wrote:
>
> > It looks like transport_set_verbosity gets called correctly, and th=
en
> > sets the "progress" flag for the transport. But for the push side, =
I
> > don't see any transports actually looking at that flag. I think the=
re
> > needs to be code in git_transport_push to handle the progress flag,=
 and
> > it just isn't there.
>
> Here's a quick 5-minute patch. It works on my test case:
>
> =A0rm -rf parent child
> =A0git init parent &&
> =A0git clone parent child &&
> =A0cd child &&
> =A0echo content >file && git add file && git commit -m one &&
> =A0git push --progress origin master:foo >foo.out 2>&1 &&
> =A0cat foo.out
>
> but I didn't even run the test suite. Maybe somebody more clueful in =
the
> area can pick it up?
>
> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> index 481602d..efd9be6 100644
> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c
> @@ -48,6 +48,7 @@ static int pack_objects(int fd, struct ref *refs, s=
truct extra_have_objects *ext
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0NULL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0NULL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0NULL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 NULL,
> =A0 =A0 =A0 =A0};
> =A0 =A0 =A0 =A0struct child_process po;
> =A0 =A0 =A0 =A0int i;
> @@ -59,6 +60,8 @@ static int pack_objects(int fd, struct ref *refs, s=
truct extra_have_objects *ext
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0argv[i++] =3D "--delta-base-offset";
> =A0 =A0 =A0 =A0if (args->quiet)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0argv[i++] =3D "-q";
> + =A0 =A0 =A0 if (args->progress)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 argv[i++] =3D "--progress";
> =A0 =A0 =A0 =A0memset(&po, 0, sizeof(po));
> =A0 =A0 =A0 =A0po.argv =3D argv;
> =A0 =A0 =A0 =A0po.in =3D -1;
> diff --git a/send-pack.h b/send-pack.h
> index 60b4ba6..fcf4707 100644
> --- a/send-pack.h
> +++ b/send-pack.h
> @@ -4,6 +4,7 @@
> =A0struct send_pack_args {
> =A0 =A0 =A0 =A0unsigned verbose:1,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0quiet:1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 progress:1,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0porcelain:1,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0send_mirror:1,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0force_update:1,
> diff --git a/transport.c b/transport.c
> index 4dba6f8..0078660 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -789,6 +789,7 @@ static int git_transport_push(struct transport *t=
ransport, struct ref *remote_re
> =A0 =A0 =A0 =A0args.use_thin_pack =3D data->options.thin;
> =A0 =A0 =A0 =A0args.verbose =3D (transport->verbose > 0);
> =A0 =A0 =A0 =A0args.quiet =3D (transport->verbose < 0);
> + =A0 =A0 =A0 args.progress =3D transport->progress;
> =A0 =A0 =A0 =A0args.dry_run =3D !!(flags & TRANSPORT_PUSH_DRY_RUN);
> =A0 =A0 =A0 =A0args.porcelain =3D !!(flags & TRANSPORT_PUSH_PORCELAIN=
);
>
