From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: [PATCH v2 4/4] diff: mark any file larger than core.bigfilethreshold
 binary
Date: Fri, 27 Jun 2014 20:56:17 +0200
Message-ID: <53ADBE51.9050005@virtuell-zuhause.de>
References: <1401368227-14469-1-git-send-email-pclouds@gmail.com>	<1403610336-27761-1-git-send-email-pclouds@gmail.com>	<1403610336-27761-4-git-send-email-pclouds@gmail.com> <xmqqegyb5zeh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, worley@alum.mit.edu
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?UTF-8?B?YyBEdXk=?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 20:56:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0bK2-00014f-Ce
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 20:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570AbaF0S41 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Jun 2014 14:56:27 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:60877 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751531AbaF0S40 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jun 2014 14:56:26 -0400
Received: from p5ddc0fb2.dip0.t-ipconnect.de ([93.220.15.178] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1X0bJt-00019c-9O; Fri, 27 Jun 2014 20:56:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqegyb5zeh.fsf@gitster.dls.corp.google.com>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1403895385;0c1413f3;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252571>

Am 26.06.2014 19:55, schrieb Junio C Hamano:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>=20
>> Too large files may lead to failure to allocate memory. If it happen=
s
>> here, it could impact quite a few commands that involve
>> diff. Moreover, too large files are inefficient to compare anyway (a=
nd
>> most likely non-text), so mark them binary and skip looking at their
>> content.
>> ...
>> diff --git a/diff.c b/diff.c
>> index a489540..7a977aa 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -2185,8 +2185,8 @@ int diff_filespec_is_binary(struct diff_filesp=
ec *one)
>>  			one->is_binary =3D one->driver->binary;
>>  		else {
>>  			if (!one->data && DIFF_FILE_VALID(one))
>> -				diff_populate_filespec(one, 0);
>> -			if (one->data)
>> +				diff_populate_filespec(one, DIFF_POPULATE_IS_BINARY);
>> +			if (one->is_binary =3D=3D -1 && one->data)
>>  				one->is_binary =3D buffer_is_binary(one->data,
>>  						one->size);
>>  			if (one->is_binary =3D=3D -1)
>=20
> The name is misleading and forced me to read it twice before I
> realized that this is "populating the is-binary bit".  It might make
> it a bit better if you renamed it to DIFF_POPULATE_IS_BINARY_BIT or
> perhaps DIFF_POPULATE_CHECK_BINARY or something.  For consistency,
> the other bit may want to be also renamed from SIZE_ONLY to either
>=20
>  (1) CHECK_SIZE_ONLY
>=20
>  (2) One bit for CHECK_SIZE, another for NO_CONTENTS, and optionally
>      make SIZE_ONLY the union of two
>=20
> I do not have strong preference either way; the latter may be more
> logical in that "not loading contents" and "check size" are sort of
> orthogonal in that you can later choose to check, without loading
> contents, only the binary-ness without checking size, but no calles
> that passes a non-zero flag to the populate-filespec function will
> want to slurp in the contents in practice, so in that sense we could
> declare that the NO_CONENTS bit is implied.
>=20
> But more importantly, would this patch actually help?  For one
> thing, this wouldn't (and shouldn't) help if the user wants --binary
> diff out of us anyway, I suspect, but I wonder what the following
> codepath in the builtin_diff() function would do:
>=20
> 		...
> 	} else if (!DIFF_OPT_TST(o, TEXT) &&
> 	    ( (!textconv_one && diff_filespec_is_binary(one)) ||
> 	      (!textconv_two && diff_filespec_is_binary(two)) )) {
> 		if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
> 			die("unable to read files to diff");
> 		/* Quite common confusing case */
> 		if (mf1.size =3D=3D mf2.size &&
> 		    !memcmp(mf1.ptr, mf2.ptr, mf1.size)) {
> 			if (must_show_header)
> 				fprintf(o->file, "%s", header.buf);
> 			goto free_ab_and_return;
> 		}
> 		fprintf(o->file, "%s", header.buf);
> 		strbuf_reset(&header);
> 		if (DIFF_OPT_TST(o, BINARY))
> 			emit_binary_diff(o->file, &mf1, &mf2, line_prefix);
> 		else
> 			fprintf(o->file, "%sBinary files %s and %s differ\n",
> 				line_prefix, lbl[0], lbl[1]);
> 		o->found_changes =3D 1;
> 	} else {
> 		...
>=20
> If we weren't told with --text/-a to force textual output, and
> at least one of the sides is marked as binary (and this patch marks
> a large blob as binary unless attributes says otherwise), we still
> call fill_mmfile() on them to slurp the contents to be compared, no?
>=20
> And before you get to the DIFF_OPT_TST(o, BINARY), you memcmp(3) to
> check if the sides are identical, so...

Good point. So how about an additional change roughly sketched as

@@ -2223,6 +2223,14 @@ struct userdiff_driver *get_textconv(struct
diff_filespec *one)
 	return userdiff_get_textconv(one->driver);
 }

+/* read the files in small chunks into memory and compare them */
+static int filecmp_chunked(struct diff_filespec *one,
+	struct diff_filespec *two)
+{
+	// TODO add implementation
+	return 0;
+}
+
 static void builtin_diff(const char *name_a,
 			 const char *name_b,
 			 struct diff_filespec *one,
@@ -2325,19 +2333,26 @@ static void builtin_diff(const char *name_a,
 	} else if (!DIFF_OPT_TST(o, TEXT) &&
 	    ( (!textconv_one && diff_filespec_is_binary(one)) ||
 	      (!textconv_two && diff_filespec_is_binary(two)) )) {
-		if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2,two)< 0)
-			die("unable to read files to diff");
+
+		unsigned long size1 =3D diff_filespec_size(one);
+		unsigned long size2 =3D diff_filespec_size(two);
+
+		if (size1 =3D=3D 0 || size2 =3D=3D 0)
+			die("unable to retrieve file sizes for diff");
 		/* Quite common confusing case */
-		if (mf1.size =3D=3D mf2.size &&
-		    !memcmp(mf1.ptr, mf2.ptr, mf1.size)) {
+		if (size1 =3D=3D size2 && !filecmp_chunked(one,two)) {
 			if (must_show_header)
 				fprintf(o->file, "%s", header.buf);
 			goto free_ab_and_return;
 		}
 		fprintf(o->file, "%s", header.buf);
 		strbuf_reset(&header);
-		if (DIFF_OPT_TST(o, BINARY))
+		if (DIFF_OPT_TST(o, BINARY)) {
+			if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
+				die("unable to read files to diff");
 			emit_binary_diff(o->file, &mf1, &mf2, line_prefix);
+		}
 		else
 			fprintf(o->file, "%sBinary files %s and %s differ\n",
 				line_prefix, lbl[0], lbl[1]);

Then the default diff case, no BINARY flag, would not read both files i=
nto memory.
filecmp_chunked will be slower than file_mmfile and memcmp, but its who=
le purpose is to read and compare the files in chunks.
The chunk size can be something like 64MiB.
