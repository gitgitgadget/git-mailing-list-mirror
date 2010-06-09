From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] Improve parent blame to detect renames by using the 
	previous information
Date: Wed, 9 Jun 2010 12:10:12 -0400
Message-ID: <AANLkTimGXAXg7fi3zKD3f-pIht0q0qYPp_6ivlt8LgDF@mail.gmail.com>
References: <20100523075503.GA24598@coredump.intra.peff.net> 
	<1275767765-8509-1-git-send-email-fonseca@diku.dk> <20100606223545.GA11424@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 09 18:10:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMNrW-00089Y-Dz
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 18:10:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086Ab0FIQKf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jun 2010 12:10:35 -0400
Received: from mail-yw0-f204.google.com ([209.85.211.204]:43202 "EHLO
	mail-yw0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000Ab0FIQKe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jun 2010 12:10:34 -0400
Received: by ywh42 with SMTP id 42so5624802ywh.15
        for <git@vger.kernel.org>; Wed, 09 Jun 2010 09:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=yfuRKSmBotHAOf9PKDVR5iaG4d7st1Q+NwufSYjUTEo=;
        b=VZ6tZv8PTYcXMDh0uoALxe53xdhaRkb243O/EBuTxanXejz9zyap1u6y4pOsmzMaSU
         qeRnA7zxO9OlNdsmM1WWlXzUjz/FaWBdL5nr4RIxrws6J2RsBSe86TtZt/T0p0HpEu9G
         +D7+CpHcjb9AHVs7tSCDocSAzOXguaL0D5H9M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=uEcDR8PdijALptTFyB84v8yrpV87zjVDBCouHDHW25d4RfDSVsF5e+7YutriENnShR
         0j1/VgAZlI31xIa2j5TTTCJS+m4Ka2HRgcOqYm9Mtj5XZ+CoqBlsQQmcN3ZK+Gp1C6/v
         ka1gZLtSmL5iwz595igmTQHa7p4YscALY8RAk=
Received: by 10.150.56.32 with SMTP id e32mr2159222yba.127.1276099832237; Wed, 
	09 Jun 2010 09:10:32 -0700 (PDT)
Received: by 10.231.206.145 with HTTP; Wed, 9 Jun 2010 09:10:12 -0700 (PDT)
In-Reply-To: <20100606223545.GA11424@coredump.intra.peff.net>
X-Google-Sender-Auth: 29JvevEucZdhW7zxzIlcME946i8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148790>

On Sun, Jun 6, 2010 at 18:35, Jeff King <peff@peff.net> wrote:
>
> On Sat, Jun 05, 2010 at 03:56:05PM -0400, Jonas Fonseca wrote:
>
> One minor bug:
>
> > @@ -5204,10 +5148,13 @@ blame_request(struct view *view, enum reque=
st request, struct line *line)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> >
> > =C2=A0 =C2=A0 =C2=A0 case REQ_PARENT:
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (check_blame_commit(=
blame, TRUE) &&
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 select_co=
mmit_parent(blame->commit->id, opt_ref,
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0blame=
->commit->filename)) {
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 string_copy(opt_file, blame->commit->filename);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!check_blame_commit=
(blame, TRUE))
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 break;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!*blame->commit->pa=
rent_id) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 report("The selected commit has no parents");
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 string_copy_rev(opt_ref, blame->commit->parent_id);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 string_copy_rev(opt_file, blame->commit->parent_filename);
>
> This second string_copy_rev should be a string_ncopy, shouldn't it?

Oh, yes, a regular copy and paste bug. Thanks for noticing. I will
include this and consider tagging another release.

--
Jonas Fonseca
