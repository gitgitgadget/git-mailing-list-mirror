From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid recalculating filename string pointer.
Date: Thu, 22 Nov 2007 12:21:04 -0800
Message-ID: <7voddm3ubz.fsf@gitster.siamese.dyndns.org>
References: <b8bf37780711211659i65a99493te3e3d5cee008ae7d@mail.gmail.com>
	<20071122195457.GB19675@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Andr=C3=A9?= Goddard Rosa <andre.goddard@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Nov 22 21:21:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvIYY-0001xU-UK
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 21:21:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbXKVUVR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Nov 2007 15:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752292AbXKVUVR
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 15:21:17 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:35115 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193AbXKVUVQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Nov 2007 15:21:16 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 612452EF;
	Thu, 22 Nov 2007 15:21:36 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id CEED1989A3;
	Thu, 22 Nov 2007 15:21:32 -0500 (EST)
In-Reply-To: <20071122195457.GB19675@glandium.org> (Mike Hommey's message of
	"Thu, 22 Nov 2007 20:54:57 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65843>

Mike Hommey <mh@glandium.org> writes:

> On Wed, Nov 21, 2007 at 10:59:41PM -0200, Andr=C3=A9 Goddard Rosa wro=
te:
>> --- a/fast-import.c
>> +++ b/fast-import.c
>> @@ -2304,11 +2304,13 @@ int main(int argc, const char **argv)
>>  		else if (!prefixcmp(a, "--export-marks=3D"))
>>  			mark_file =3D a + 15;
>>  		else if (!prefixcmp(a, "--export-pack-edges=3D")) {
>> +			char *filename =3D a + 20;
>> +
>>  			if (pack_edges)
>>  				fclose(pack_edges);
>> -			pack_edges =3D fopen(a + 20, "a");
>> +			pack_edges =3D fopen(filename, "a");
>>  			if (!pack_edges)
>> -				die("Cannot open %s: %s", a + 20, strerror(errno));
>> +				die("Cannot open %s: %s", filename, strerror(errno));
>>  		} else if (!strcmp(a, "--force"))
>>  			force_update =3D 1;
>>  		else if (!strcmp(a, "--quiet"))
>
> Normally, the compiler takes care of such optimizations. It actually
> takes care of it much better than you can do yourself, and doing it
> yourself can even sometimes generate less optimized code because it
> gets in the compiler optimizations'way.

True, but I think another point of the patch is to address the
risk of two instances of "+ 20" going out of sync if/when the
option parsing is updated.

Not that I think Andr=C3=A9 meant the patch as defensive coding (the
subject suggests it was meant to be a micro-optimization), nor
this is the good way to address that risk factor (parse-options
may be a better match for it).
