From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] submodule: Include check for objects when fetching
Date: Mon, 22 Feb 2016 15:06:22 -0800
Message-ID: <xmqqk2lw4a6p.fsf@gitster.mtv.corp.google.com>
References: <1456180548-20996-1-git-send-email-sbeller@google.com>
	<1456180548-20996-2-git-send-email-sbeller@google.com>
	<xmqqoab84apu.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, dborowitz@google.com,
	jacob.keller@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 00:06:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXzYl-0005LZ-Rw
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 00:06:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756444AbcBVXG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 18:06:26 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59447 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755481AbcBVXGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 18:06:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D6BE347558;
	Mon, 22 Feb 2016 18:06:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kZ2arUKvaGelSJRod2E39Zkb/H8=; b=BWEmom
	7KC64acU44vXibxsA9Nmtzf6AHnF8ejGkArDGAoAMkht++3Tf2DVhN2HN/XTvCsW
	rlyelzfUNgrao/39lo573ZKzqsFes0/Ox/dsDhqVYK9UZLSnijy3RyUrL3NReXEm
	GcchT6HoNMVtLzmGIvvG2nJpFjJTg9PQDkiD8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DBL8UP5nf8dy0cFVIVbznKEG89puqo7Y
	ptOAFb/3dfSvqhMRTFriqQK4f7HPUpQMd4ZUdcxiTGQ5ugHFYmKuRnWRQDjft/vO
	0qfMdVJ9TjYPhPUG676NVOd6jUioUmZmQvy6WsAN3mvnPl1ibmPaFKMcgnP/HjDJ
	VCVDlZFam8g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CDC8C47557;
	Mon, 22 Feb 2016 18:06:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5034C47556;
	Mon, 22 Feb 2016 18:06:23 -0500 (EST)
In-Reply-To: <xmqqoab84apu.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 22 Feb 2016 14:54:53 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E4608E26-D9B8-11E5-86D4-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286997>

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> Junio wrote:
>>> To be complete, the rev-list command line should also run with
>>> "--objects"; after all, a commit walker fetch may have downloaded
>>> commit chain completely but haven't fetched necessary trees and
>>> blobs when it was killed, and "rev-list $sha1 --not --all" would not
>>> catch such a breakage without "--objects".
>>
>> By adding the --objects switch to rev-list we make sure to do a complete
>> check.
>
> You also need to drop "-n1" for the command to be equivalent to
> quickfetch, I think.

Ahh, I think I need to take it back.

As the existing code relies not just on the exit status of rev-list
but also checks if anything comes out of it, having "-n1" would not
hurt.

The case I was worried about was that we have all commits to connect
$sha1 to what are reachable from refs, but some tree/blob objects
referenced by these commits were missing.  By cutting the displaying
with "-n1", rev-list may happily exit successfully after showing $sha1,
without even realizing that some trees/blobs are missing and the history
leading to $sha1 cannot be considered complete.

But because the code checks the empty-ness of $rev, this case is diagnosed
as "$sha1 is not reachable from any of the refs" correctly anyway,
so it should be OK.

>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  git-submodule.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index 9bc5c5f..f5d6675 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -746,7 +746,7 @@ Maybe you want to use 'update --init'?")"
>>  				# Run fetch only if $sha1 isn't present or it
>>  				# is not reachable from a ref.
>>  				(clear_local_git_env; cd "$sm_path" &&
>> -					( (rev=$(git rev-list -n 1 $sha1 --not --all 2>/dev/null) &&
>> +					( (rev=$(git rev-list --objects -n 1 $sha1 --not --all 2>/dev/null) &&
>>  					 test -z "$rev") || git-fetch)) ||
>>  				die "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'")"
>>  			fi
