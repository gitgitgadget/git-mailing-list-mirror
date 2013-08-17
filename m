From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [RFC PATCHv2] repack: rewrite the shell script in C.
Date: Sat, 17 Aug 2013 12:18:24 -0700
Message-ID: <C3ED0A6F-4C7E-4433-966C-6EE00B9AAFEE@gmail.com>
References: <7v8v02swnc.fsf@alter.siamese.dyndns.org> <1376611978-13189-1-git-send-email-stefanbeller@googlemail.com> <520F7BDE.9090902@web.de>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, mfick@codeaurora.org,
	apelisse@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	pclouds@gmail.com, iveqy@iveqy.com,
	Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Aug 17 21:18:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAm1A-0005hU-5U
	for gcvg-git-2@plane.gmane.org; Sat, 17 Aug 2013 21:18:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754267Ab3HQTS2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Aug 2013 15:18:28 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:46653 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754167Ab3HQTS1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Aug 2013 15:18:27 -0400
Received: by mail-pd0-f169.google.com with SMTP id r10so3483111pdi.28
        for <git@vger.kernel.org>; Sat, 17 Aug 2013 12:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=f7s2OkPF53ZmZw5QEamWjpqZ6MyiFqxiqXiV1vh6zHw=;
        b=MHxOhbFU0H5oF/tnlGTZxcOxEvXi4hPZcIzDm+dLXMr7mmoomwxrVutAcF5F1YejLk
         5puLGmFbQNje1JyRgjDGmG1IWIvtdDAYr+5j7nO/BsOqG0qiVmMAS40APCwMlcdl81Nw
         A4vbscHoIL/jfOKg3Pw3dekll+ENhSt/R27xiBC7DwrqlJJdjO3t0vYIBwjyD4ZzKad3
         t63VZWJYrw3xbS4G/hgdcTQgsu+9qEXz6wvW+M6qe4xAa0rfhqnMhrYCPTncM5BCWSl4
         lQYOBhsZO1mwee6hQOXI5Exm09TKXMiJ/zfPuFlvHV0l+UA0ABfvGWD5ihdejUiCwYIN
         AiDg==
X-Received: by 10.66.227.39 with SMTP id rx7mr4365975pac.44.1376767107481;
        Sat, 17 Aug 2013 12:18:27 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id pu5sm5592024pac.21.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 17 Aug 2013 12:18:26 -0700 (PDT)
In-Reply-To: <520F7BDE.9090902@web.de>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232468>

On Aug 17, 2013, at 06:34, Ren=E9 Scharfe wrote:
> On Aug 15, 2013, at 17:12, Stefan Beller wrote:
>> +		if (sha_begin >=3D e->d_name && !strncmp(sha_begin, sha1, 40)) {
>> +			char *fname;
>> +			fname =3D xmalloc(strlen(path) + 1 + strlen(e->d_name));

This needs another +1 because

>> +			sprintf(fname, "%s/%s", path, e->d_name);

len(path) + len("/") + len(e->d_name) + len("\0")

>
> mkpathdup..
>
>> +			unlink(fname);
>> +			/*TODO: free(fname); fails here sometimes, needs investigation*/
>
> Strange.  Perhaps valgrind can tell you what's wrong.

which is probably why it fails since the byte beyond the end of fname =20
is being overwritten with a nul.