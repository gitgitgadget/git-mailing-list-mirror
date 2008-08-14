From: Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH 2] count-objects: add human-readable size option
Date: Thu, 14 Aug 2008 10:26:07 -0400
Message-ID: <48A4407F.6080902@griep.us>
References: <1218657910-22096-1-git-send-email-marcus@griep.us> <1218687684-11671-1-git-send-email-marcus@griep.us> <20080814043817.GC11232@spearce.org> <7vskt8f9x2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 16:27:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTdnJ-0005Cg-LB
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 16:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbYHNO0N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Aug 2008 10:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbYHNO0N
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 10:26:13 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:18980 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbYHNO0M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 10:26:12 -0400
Received: by wr-out-0506.google.com with SMTP id 69so555413wri.5
        for <git@vger.kernel.org>; Thu, 14 Aug 2008 07:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=94KHCOpbtjHPEL0wtnTbrvxD8+FBwnrZjDp8xi3MdlA=;
        b=JHSQFfLiQj5Ky5ifbTH1XfkpCyZvwPRkGiB6PFoQOb2KWPiBRXjDGbgQZQci9YnhSD
         UtiV74D4DlP136nXvkaQeCcTZfdvU1IcUf1mM63IxUPp5ABPQleWWjzVpzHXumX09WUM
         r/n3iBuCDod9JMjKIlNu93+tA5rln/y+sBcK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=g0MKT6oIYEUt1g14VWZPjAfHTjXiONHo6jwX2TVFZFe9Dl9rNZwvtbrLIZUkdkatVe
         2ceZrxiv2UuYCa1CouQK1Wb7ZuR7IJrM75fztUBBahJtb4CWYLku8xRWlR6oa7guSSa2
         006FoeTZA8fZKDxvwtOmed4AF2RbQmR3Sg6j0=
Received: by 10.90.55.20 with SMTP id d20mr1909201aga.65.1218723971543;
        Thu, 14 Aug 2008 07:26:11 -0700 (PDT)
Received: from ?192.168.1.3? ( [71.174.65.78])
        by mx.google.com with ESMTPS id 71sm2713505wry.16.2008.08.14.07.26.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 14 Aug 2008 07:26:10 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <7vskt8f9x2.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92363>

Junio C Hamano wrote:
>     extern int human_readable(struct strbuf *,
>     			      double value, int precision,
>                               const char **unit);
>=20
>     static const char **size_unit =3D {
>     	"byte", "KB", "MB", "GB", NULL,
>     };
>     static const char **throughput_unit =3D {
>     	"bps", "Kbps", "Mbps", "Gbps", NULL,
>     };
>=20
>     human_readble(&sb, (double) bytes_transferred, 0, size_unit);
>     human_readble(&sb, (double) throughput, 2, throughput_unit);

Here's what I'm looking at as a new signature:

extern int strbuf_add_human_readable(struct strbuf *,
				double value, int maxlen,
				int scale, const char *suffix,
				int flags);

where 'maxlen' specifies the longest string that should be returned.
That will make it easier for any pretty-ish formatting like ls and
du use. A value of 0 is unlimited length.

'scale' is used to specify a boundary, above which value should be
reduced, and below which it should be reported. Commonly this is
1000.  If 0, then it will find a scale that best fits into 'maxlen'.
If both 'maxlen' and 'scale' are 0, then it will use the default
of 1000.

'suffix' is appended onto every formatted string.  This would often be
"", "B", "bps".

'flags' would provide the ability to switch between a binary (1024)
and an si (1000) period.  Also, adding a space between number and
unit.

On success, would return 0.  If maxlen is specified and there is not
enough space given the scale or an inordinately large value, return
-n, where n is the amount of additional length that would have been
needed.

Does this sound appropriate?

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4
