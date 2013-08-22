From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] repack: rewrite the shell script in C.
Date: Thu, 22 Aug 2013 12:46:50 +0200
Message-ID: <5215EC1A.7060004@kdbg.org>
References: <5213EF74.7020408@googlemail.com> <1377038334-15799-1-git-send-email-stefanbeller@googlemail.com> <vpqhaeje8e0.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <stefanbeller@googlemail.com>, git@vger.kernel.org,
	mfick@codeaurora.org, apelisse@gmail.com, pclouds@gmail.com,
	iveqy@iveqy.com, gitster@pobox.com, mackyle@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Aug 22 12:54:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCSX1-0000ke-Mo
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 12:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834Ab3HVKyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Aug 2013 06:54:20 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:24473 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752503Ab3HVKyT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Aug 2013 06:54:19 -0400
Received: from [10.75.26.165] (178.115.250.165.wireless.dyn.drei.com [178.115.250.165])
	by bsmtp.bon.at (Postfix) with ESMTP id 7678B130072;
	Thu, 22 Aug 2013 12:54:16 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <vpqhaeje8e0.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232763>

Am 21.08.2013 10:49, schrieb Matthieu Moy:
> Stefan Beller <stefanbeller@googlemail.com> writes:
>> +	for_each_string_list_item(item, &names) {
>> +		for (ext = 0; ext < 2; ext++) {
>> +			char *fname, *fname_old;
>> +			fname = mkpathdup("%s/%s%s", packdir, item->string, exts[ext]);
>> +			if (!file_exists(fname)) {
>> +				free(fname);
>> +				continue;
>> +			}
>> +
>> +			fname_old = mkpath("%s/old-%s%s", packdir, item->string, exts[ext]);
>> +			if (file_exists(fname_old))
>> +				unlink(fname_old);
>
> Unchecked returned value.

Good catch! The original was 'rm -f ... && mv ... || failed=t'

>> +	/* Now the ones with the same name are out of the way... */
>> +	for_each_string_list_item(item, &names) {
>> +		for (ext = 0; ext < 2; ext++) {
>> +			char *fname, *fname_old;
>> +			struct stat statbuffer;
>> +			fname = mkpathdup("%s/pack-%s%s", packdir, item->string, exts[ext]);
>> +			fname_old = mkpath("%s-%s%s", packtmp, item->string, exts[ext]);
>> +			if (!stat(fname_old, &statbuffer)) {
>> +				statbuffer.st_mode &= ~S_IWUSR | ~S_IWGRP | ~S_IWOTH;
>> +				chmod(fname_old, statbuffer.st_mode);
>
> Unchecked return value.

The original was an unchecked 'chmod a-w', so we don't care.

Of course, we could mimic the original better by issuing warnings.

>
>> +	/* Remove the "old-" files */
>> +	for_each_string_list_item(item, &names) {
>> +		char *fname;
>> +		fname = mkpath("%s/old-pack-%s.idx", packdir, item->string);
>> +		if (remove_path(fname))
>> +			die_errno(_("removing '%s' failed"), fname);
>> +
>> +		fname = mkpath("%s/old-pack-%s.pack", packdir, item->string);
>> +		if (remove_path(fname))
>> +			die_errno(_("removing '%s' failed"), fname);
>
> Does this have to be a fatal error? If I read correctly, it wasn't fatal
> in the shell version.

Good catch.

-- Hannes
