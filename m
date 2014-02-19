From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 24/25] prune: strategies for linked checkouts
Date: Wed, 19 Feb 2014 17:53:12 -0500
Message-ID: <CAPig+cQFw+8RE_zPntCkqKyYGK0rXVFQ=OxrBS6MeFEpw5-cEA@mail.gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1392730814-19656-25-git-send-email-pclouds@gmail.com>
	<CAPig+cQgphSBA6iAYqLJ7RnEwSzBA1dApcLWAydZEXarQRcTKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 19 23:53:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGG1E-0003oR-0t
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 23:53:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbaBSWxO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Feb 2014 17:53:14 -0500
Received: from mail-qa0-f49.google.com ([209.85.216.49]:38231 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029AbaBSWxN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Feb 2014 17:53:13 -0500
Received: by mail-qa0-f49.google.com with SMTP id w8so1716770qac.22
        for <git@vger.kernel.org>; Wed, 19 Feb 2014 14:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=d3Qf7AdUZ6kw5W/RFzKW9bYndUKDJLEYf9Lv98MMXxo=;
        b=NqBcQ/3KahEOfzEZoKq4Pkzoxok9NOsTkjiqaE9kx0zoir2DTM1C4kdBNOLbBEc/Xu
         En4p4TCMEcYP+hwR0fMD2W9QkbURfCOrE1MlElBji0v0ns/Zu4FXE2wM3jl9R5fhSAkv
         Mc0N3Yzbh7meq4V0YNFVX7LAQnYn5rBzLt1yOJu5m3TeKppWdltmqsjLsoIN7XYJcAyW
         Qj8aqffvkUgp6Iwco8QNxovM5+jkUML/kn2OMF8lHDVUe4vxZrEKTKnCYGIbORGTkHV4
         RWeZUeYWuExIwbeGAWUbkg1RX5D5ZpIGibhJ3m3v3BtqSIer0pp5lyeZf6Pogprq1sKl
         tWSw==
X-Received: by 10.236.50.194 with SMTP id z42mr7050063yhb.145.1392850392952;
 Wed, 19 Feb 2014 14:53:12 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Wed, 19 Feb 2014 14:53:12 -0800 (PST)
In-Reply-To: <CAPig+cQgphSBA6iAYqLJ7RnEwSzBA1dApcLWAydZEXarQRcTKQ@mail.gmail.com>
X-Google-Sender-Auth: zmWKg12xqYht5BRIZa_C0C7FOaU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242415>

On Wed, Feb 19, 2014 at 5:08 PM, Eric Sunshine <sunshine@sunshineco.com=
> wrote:
> On Tue, Feb 18, 2014 at 8:40 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>> +static dev_t get_device_or_die(const char *path)
>> +{
>> +       struct stat buf;
>> +       if (stat(path, &buf))
>> +               die_errno("failed to stat '%s'", path);
>> +       /* Ah Windows! Make different drives different "partitions" =
*/
>> +       if (buf.st_dev =3D=3D 0 && has_dos_drive_prefix("c:\\"))
>> +               buf.st_dev =3D toupper(real_path(path)[0]);
>
> This invocation of has_dos_drive_prefix() with hardcoded "c:\\" at
> first looks like an error until the reader realizes that it's an
> #ifdef-less check if the platforms is Windows. Would it make more
> sense to encapsulate this anomaly and abstract it away by fixing
> compat/mingw.c:do_lstat() to instead set 'st_dev' automatically like
> you do here? In particular, this line in mingw.c:
>
>     buf->st_dev =3D buf->st_rdev =3D 0; /* not used by Git */
>
>> +       return buf.st_dev;

Or, if doing this in do_lstat() is too expensive for normal stat()
operations (which is likely), then a simple #ifdef might be easier to
read; or abstract it into a get_device() function which Windows/MinGW
can override, doing buf.st_dev =3D toupper(real_path(...)), thus also
making the code easier to understand.
