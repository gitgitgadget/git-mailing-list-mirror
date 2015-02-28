From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 2/5] upload-pack: support out of band client
 capability requests
Date: Sat, 28 Feb 2015 18:22:59 +0700
Message-ID: <CACsJy8DA86yBoYxvEbgUzoxGOwsKw0mO50iQ0qvNrxaihRNe2g@mail.gmail.com>
References: <CAGZ79ka8Zg86qqvWByNiP3F6a9QggO-bNY3ZZ9g+A-MdKYQ7NQ@mail.gmail.com>
 <1425085318-30537-1-git-send-email-sbeller@google.com> <1425085318-30537-3-git-send-email-sbeller@google.com>
 <AB630BA1-8D48-418D-B576-6495DBE67C52@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 28 12:23:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRfUf-0005uu-Fj
	for gcvg-git-2@plane.gmane.org; Sat, 28 Feb 2015 12:23:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbbB1LXb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Feb 2015 06:23:31 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:38763 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbbB1LXa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Feb 2015 06:23:30 -0500
Received: by iecrd18 with SMTP id rd18so37199737iec.5
        for <git@vger.kernel.org>; Sat, 28 Feb 2015 03:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=jByRjjxD2lQjOcy34M0lT2n3dKyfmhYMPI656VMW5+w=;
        b=OfZ56OWMcWL+pHmgB+pTJ18/WKABG5pTsSfVb/O3qK077+PDTWfLX+f+k/qR8ZnGW3
         qkvy0bRSxGLZURkQy46X4X40U9ODoElFfjRKDjZLtSnwIcVBCjRJ+oqNd8Ml4IIvm/7I
         JgPV49iaMA68rzlUZFdsmtvfj/WqTB3kHd0PyMmy/C20XIftmk/ywDxtp5pzB4JFdVon
         NGZlgXLs9D3d+d/5vJjXIQm8FTNTaRhidIKNOzmc5VFpAzb3q8N4lrDGEwtmegs6vSZB
         tJDMmHd6dyCYTYW4Z+XmnZaF7QgsFH+lUmk5wdyAvH2seE9bYE62OQvGZkXEXHZOct6U
         6njQ==
X-Received: by 10.42.109.20 with SMTP id j20mr19994209icp.27.1425122610111;
 Sat, 28 Feb 2015 03:23:30 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Sat, 28 Feb 2015 03:22:59 -0800 (PST)
In-Reply-To: <AB630BA1-8D48-418D-B576-6495DBE67C52@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264526>

On Sat, Feb 28, 2015 at 2:47 PM, Kyle J. McKay <mackyle@gmail.com> wrot=
e:
> On Feb 27, 2015, at 17:01, Stefan Beller wrote:
>>
>> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>>
>> The only difference from the original protocol client capabilities a=
re
>> negotiated before initial refs advertisment.
>>
>> Client capabilities are sent out of band (upload-pack receives it as
>> the second command line argument). The server sends one pkt-line bac=
k
>> advertising its capabilities.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>
>> Notes:
>>    v1:
>>    I am still undecided if the client should then accept/resend
>>    the capabilities to confirm them, which would make the client the
>>    ultimate decider which capabilities are used.
>>
>>    My gut feeling is to rather let the server make the final decisio=
n
>>    for the capabilities, as it will use some requested capabilities
>>    already to not send out all the refs.
>>
>> Documentation/git-upload-pack.txt | 10 +++++++++-
>> upload-pack.c                     | 42
>> +++++++++++++++++++++++++++------------
>> 2 files changed, 38 insertions(+), 14 deletions(-)
>>
>> diff --git a/Documentation/git-upload-pack.txt
>> b/Documentation/git-upload-pack.txt
>> index 0abc806..ad3a89d 100644
>> --- a/Documentation/git-upload-pack.txt
>> +++ b/Documentation/git-upload-pack.txt
>> @@ -9,7 +9,7 @@ git-upload-pack - Send objects packed back to
>> git-fetch-pack
>> SYNOPSIS
>> --------
>> [verse]
>> -'git-upload-pack' [--strict] [--timeout=3D<n>] <directory>
>> +'git-upload-pack' [--strict] [--timeout=3D<n>] <directory> [<capabi=
lities>]
>
>
> Isn't the problem with this that passing the extra argument to ssh se=
rvers
> will cause them to fail?
>
> Having just looked at the upload-pack.c source it looks to me like tr=
ying to
> send "git-upload-pack 'dir' 'capabilities'" to an ssh git server runn=
ing a
> current version of the code will just end up failing.  I realize the =
extra
> argument is optional, so does that mean there's no out-of-band suppor=
t for
> ssh connections since the extra argument would have to be omitted to =
remain
> compatible?

The client should only trigger this behavior when it knows the server
can deal with it. And that is possible because in the last fetch, the
server has told the client that it's capable of receiving this
capabilities argument. Backward compatibility is a concern at client
side, not server side.

> I've looked at those links and it's unclear to me how they support an
> out-of-band option for ssh, they seem to be targeted at git-daemon.  =
Maybe
> there's another reference?

=46or ssh, I think connect.c is the one that constructs and executes ss=
h command.
--=20
Duy
