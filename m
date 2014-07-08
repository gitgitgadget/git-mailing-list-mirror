From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v20 31/48] receive-pack.c: use a reference transaction
 for updating the refs
Date: Tue, 08 Jul 2014 15:20:22 +0200
Message-ID: <53BBF016.7040107@alum.mit.edu>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com> <1403275409-28173-32-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 15:27:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4VQk-0005O0-0c
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 15:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbaGHN13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 09:27:29 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:57207 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932184AbaGHN10 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jul 2014 09:27:26 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jul 2014 09:27:26 EDT
X-AuditID: 12074411-f79d86d000006a97-12-53bbf018d525
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id A6.06.27287.810FBB35; Tue,  8 Jul 2014 09:20:24 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97EC0.dip0.t-ipconnect.de [79.201.126.192])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s68DKMIQ032582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 8 Jul 2014 09:20:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <1403275409-28173-32-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42IRYndR1JX4sDvY4HcLj0XXlW4mi38TahyY
	PBZsKvX4vEkugCmK2yYpsaQsODM9T98ugTvj3oIm1oKXbBVXnv9laWC8wdrFyMkhIWAisbbh
	HwuELSZx4d56ti5GLg4hgcuMEtMmbGOEcM4zSXw6fJsJpIpXQFti/pLjjCA2i4CqRMuzNmYQ
	m01AV2JRTzNYjahAkMTsz/PYIeoFJU7OfAK2QUTATmL9rYVg9cICSRI7V0DYQgI1Erf6z4Nd
	xCngKvH672ygeg6gi8QlehqDQMLMAjoS7/oeMEPY8hLb385hnsAoMAvJhllIymYhKVvAyLyK
	US4xpzRXNzcxM6c4NVm3ODkxLy+1SNdULzezRC81pXQTIyRIBXcwzjgpd4hRgINRiYd3xcFd
	wUKsiWXFlbmHGCU5mJREee+83R0sxJeUn1KZkVicEV9UmpNafIhRgoNZSYT3yymgHG9KYmVV
	alE+TEqag0VJnJdvibqfkEB6YklqdmpqQWoRTFaGg0NJgvfOO6BGwaLU9NSKtMycEoQ0Ewcn
	yHAuKZHi1LyU1KLE0pKMeFCkxhcDYxUkxQO0dyVIO29xQWIuUBSi9RSjopQ4LzNIQgAkkVGa
	BzcWlnpeMYoDfSnMuxWkigeYtuC6XwENZgIa/Pn9DpDBJYkIKakGxuQfEXXbr7cfXRInsXLr
	5r9C9mmNTArrz34Lf9kYfMx29Va9W4J+X/P3Xvsnelz4QFvQ+rXBW3oiuv4+ShQtqA8oTqkN
	DVv94XltkIG97yn/huvrYmcqPt6xqXra0/v5+yITFfk70/7tumA494dq7/7CeMvT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253022>

On 06/20/2014 04:43 PM, Ronnie Sahlberg wrote:
> Wrap all the ref updates inside a transaction.
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  builtin/receive-pack.c | 96 +++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 63 insertions(+), 33 deletions(-)
> 
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index c323081..b51f8ae 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> [...]
> @@ -647,6 +654,9 @@ static void check_aliased_update(struct command *cmd, struct string_list *list)
>  	char cmd_oldh[41], cmd_newh[41], dst_oldh[41], dst_newh[41];
>  	int flag;
>  
> +	if (cmd->error_string)
> +		die("BUG: check_alised_update called with failed cmd");

s/check_alised_update/check_aliased_update/

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
