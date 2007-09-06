From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH 2/7] Simplify strbuf uses in archive-tar.c using the 
	proper functions.
Date: Thu, 06 Sep 2007 14:18:34 -0400
Message-ID: <1189102714.3423.22.camel@hinata.boston.redhat.com>
References: <20070902224213.GB431@artemis.corp>
	 <11890776114037-git-send-email-madcoder@debian.org>
	 <118907761140-git-send-email-madcoder@debian.org>
	 <11890776111843-git-send-email-madcoder@debian.org>
	 <1189101569.3423.17.camel@hinata.boston.redhat.com>
	 <20070906180858.GJ8451@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 20:18:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITLwG-0004Ge-OG
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 20:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755964AbXIFSSo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 6 Sep 2007 14:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755963AbXIFSSo
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 14:18:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42574 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755948AbXIFSSn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 14:18:43 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l86IIfCP002975;
	Thu, 6 Sep 2007 14:18:41 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l86IIf8J018324;
	Thu, 6 Sep 2007 14:18:41 -0400
Received: from [192.168.1.101] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l86IIeXD017319;
	Thu, 6 Sep 2007 14:18:40 -0400
In-Reply-To: <20070906180858.GJ8451@artemis.corp>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57923>

On Thu, 2007-09-06 at 20:08 +0200, Pierre Habouzit wrote:
> On Thu, Sep 06, 2007 at 05:59:29PM +0000, Kristian H=C3=B8gsberg wrot=
e:
> > On Thu, 2007-09-06 at 13:20 +0200, Pierre Habouzit wrote:
> > > +	strbuf_grow(sb, len);
> > > +	strbuf_addf(sb, "%u %s=3D", len, keyword);
> > > +	strbuf_add(sb, value, valuelen);
> > > +	strbuf_addch(sb, '\n');
> > >  }
> >=20
> > This entire function can be collapsed to just:
> >=20
> > 	strbuf_addf(sb, "%u %s=3D%.*s\n", len, keyword, valuelen, value);
>=20
>   yes, but it's less efficient, because %.*s says that sprintf must c=
opy
> at most valuelen bytes from value, but it still has to stop if it fin=
ds
> a \0 before. And the strbuf_grow has sense because the extend policy =
at
> snprintf time is optimistic: we try to write, and if it didn't fit, w=
e
> try again. So there is a huge benefit if we have a clue of the final
> size.

Yeah, my strbuf_addf() suggestion doesn't work, since the format seems
to indicate the embedded NULs indeed is allowed (the %u is the length o=
f
the value), so *.% could truncate data.

> > > -	memcpy(path.buf, base, baselen);
> > > -	memcpy(path.buf + baselen, filename, filenamelen);
> > > -	path.len =3D baselen + filenamelen;
> > > -	path.buf[path.len] =3D '\0';
> > > +	strbuf_grow(&path, MAX(PATH_MAX, baselen + filenamelen + 1));
> > > +	strbuf_reset(&path);
> >=20
> > Does strbuf_reset() do anything here?
> >=20
> > > +	strbuf_add(&path, base, baselen);
>=20
>   Yes _reset() sets length to 0. so the add here will write at the st=
art
> of the buffer again. It definitely is important !

But where was length set to non-zero?  path is initialized on entry to
the function, and strbuf_grow() just increases the allocation, not
length, right?

Kristian
