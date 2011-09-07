From: wanghui <Hui.Wang@windriver.com>
Subject: Re: [PATCH v2 2/5] sha1_file: remove a buggy value setting
Date: Wed, 7 Sep 2011 17:55:00 +0800
Message-ID: <4E673F74.9060006@windriver.com>
References: <1315304645-12009-1-git-send-email-Hui.Wang@windriver.com> <1315304645-12009-2-git-send-email-Hui.Wang@windriver.com> <1315304645-12009-3-git-send-email-Hui.Wang@windriver.com> <7vpqjdab76.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <tali@admingilde.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 07 19:29:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1LwC-0001mQ-6B
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 19:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755622Ab1IGR3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 13:29:10 -0400
Received: from mail.windriver.com ([147.11.1.11]:63192 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755550Ab1IGR26 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 13:28:58 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p879sjhh029344
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 7 Sep 2011 02:54:45 -0700 (PDT)
Received: from [128.224.163.220] (128.224.163.220) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.1.255.0; Wed, 7 Sep
 2011 02:54:45 -0700
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <7vpqjdab76.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180881>

Junio C Hamano wrote:
> Wang Hui <Hui.Wang@windriver.com> writes:
>
>   
>> From: Hui Wang <Hui.Wang@windriver.com>
>>
>> The ent->base[] is a character array, it has pfxlen characters from
>> position 0 to (pfxlen-1) to contain an alt object dir name, the
>> position pfxlen should be the string terminating character '\0' and
>> is deliberately set to '\0' at the previous code line. The position
>> (pfxlen+1) is given to ent->name.
>>     
>
> Correct. Do you understand why?
>
> We temporarily NUL terminate the ent->base[] so that we can give it to
> is_directory() to see if that is a directory, but the invariants for a
> alternate_object_database instance after it is properly initialized by
> this function are to have:
>
>  - the directory name followed by a slash in the base[] array;
>  - the name pointer pointing at one byte beyond the slash;
>  - name[2] filled with a slash; and
>  - name[41] terminated with NUL.
>
> Later, has_loose_object_nonlocal() calls fill_sha1_path() with the name
> pointer to fill name[0..1, 3..40] with the hexadecimal representation of
> the object name, which would result in base[] array to have the pathname
> for a loose object found in that alternate. The same thing happens in
> open_sha1_file() to read from a loose object in an alternate.
>
> And you are breaking one of the above invariants by removing that slash
> after the directory name. These callers of fill_sha1_path() will see the
> directory name, your NUL, two hex, slash, and 38 hex in base[].
>
>   
Understand now, thanks for your explanation.
> How would the code even work with your patch?
>
>
>   
