From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v3 2/3] relative_path should honor DOS and UNC paths
Date: Wed, 18 Sep 2013 17:09:59 +0200
Message-ID: <5239C247.4030909@web.de>
References: <1c0d845aca9a9ca65a7e1d481a75a0f6f4220a89.1379406453.git.worldhello.net@gmail.com> <2c56935842ceef4d5933c299dd2d55286eb0ba3a.1379406453.git.worldhello.net@gmail.com> <xmqqli2v1l7f.fsf@gitster.dls.corp.google.com> <5239BA98.9000205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	Tvangeste <i.4m.l33t@yandex.ru>, Johannes Sixt <j6t@kdbg.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 18 17:10:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMJOO-0005pz-9u
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 17:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057Ab3IRPKG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Sep 2013 11:10:06 -0400
Received: from mout.web.de ([212.227.15.14]:64298 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751396Ab3IRPKE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 11:10:04 -0400
Received: from [192.168.209.26] ([217.208.218.204]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0Md4xS-1VeOCp280o-00ICUg for <git@vger.kernel.org>;
 Wed, 18 Sep 2013 17:10:02 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <5239BA98.9000205@gmail.com>
X-Provags-ID: V03:K0:yTkGkNlsGH2U09GnN3sfZXv8C5OtLYzHU5nTRQa/sFHht1TDCty
 iD6sv+o/mZeKujztm00C2Gqq3DSaG7JLNZt2YwyIMetwxkiupmEqnW+0HTQXi5GC0NLhZjP
 iLZtlqepfuLDcGrDCVwQLRZOE4xNvtxMiIGa8iczmgtKZlt+W6c93gPOpB85/n5W0s/hV2q
 Et3mXhdIncNw8sGVB4HIw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234969>

On 2013-09-18 16.37, Torsten B=F6gershausen wrote:
> On 2013-09-17 18.12, Junio C Hamano wrote:
>> Jiang Xin <worldhello.net@gmail.com> writes:
>>
>>> diff --git a/compat/mingw.h b/compat/mingw.h
>>> index bd0a88b..06e9f49 100644
>>> --- a/compat/mingw.h
>>> +++ b/compat/mingw.h
>>> @@ -311,6 +311,15 @@ int winansi_fprintf(FILE *stream, const char *=
format, ...) __attribute__((format
>>> =20
>>>  #define has_dos_drive_prefix(path) (isalpha(*(path)) && (path)[1] =
=3D=3D ':')
>>>  #define is_dir_sep(c) ((c) =3D=3D '/' || (c) =3D=3D '\\')
>>> +static inline int is_unc_path(const char *path)
>>> +{
>>> +	if (!is_dir_sep(*path) || !is_dir_sep(*(path+1)) || is_dir_sep(*(=
path+2)))
>>> +		return 0;
>>
>> If path[1] =3D=3D '\0', it would be !is_dir_sep() and we end up
>> inspecting past the end of the string?
Yes
(If there was a previous mail, it was incomplete, sorry)

I think we want to catch "2 (back)slashes followed by a letter"
<http://msdn.microsoft.com/en-us/library/windows/desktop/aa365247%28v=3D=
vs.85%29.aspx>

#define is_unc_path(path) ((is_dir_sep(path)[0]) && is_dir_sep((path)[1=
]) && isalpha((path[2])))

Then we need=20
#define is_relative_path(path)  (((path)[0]) && !is_dir_sep((path)[1]))

And may be like this:

static int have_same_root(const char *path1, const char *path2)
{
	int is_abs1, is_abs2;

	is_abs1 =3D is_absolute_path(path1);
	is_abs2 =3D is_absolute_path(path2);
	if (is_abs1 && is_abs2) {
		if (is_unc_path(path1) && !is_relative_path(path2))
			return 0;
		if (!is_relative_path(path1) && is_unc_path(path2))
			return 0;
		return tolower(path1[0]) =3D=3D tolower(path2[0]);
	} else {
		return !is_abs1 && !is_abs2;
	}
}

Could that work?
