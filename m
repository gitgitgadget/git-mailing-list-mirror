From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 4/4] cache-tree: Write updated cache-tree after commit
Date: Mon, 14 Jul 2014 08:54:55 -0700
Message-ID: <xmqqr41oylyo.fsf@gitster.dls.corp.google.com>
References: <1405140276-32162-1-git-send-email-dturner@twitter.com>
	<1405140276-32162-4-git-send-email-dturner@twitter.com>
	<CACsJy8D0CdS5B5xNSSCk+LToXV9FnHFLkPzJ5f-7NTWiw9yn5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twitter.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 17:55:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6iar-0002zU-GM
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 17:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755926AbaGNPzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 11:55:05 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53426 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755783AbaGNPzD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 11:55:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D6F46265DD;
	Mon, 14 Jul 2014 11:54:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o2kVyuKkXkwPUNEezK6F8EQDQpc=; b=SsAN/E
	6w3FGzXE4X/1g+yzFhOyHp+SQWazC3LONXagzJE3DXrP/fpRpf8jN1lV/wiVLsku
	8ZbYKflxV9MW7N5mL/wm61JBieIUOPjS6EeNh1J+K8uqVrv7r+QvUVN/NOm5MdvP
	ks5dNEMxSg2JEvHHlOwsspgsjfpCwRhizYLEw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DFg1jVaYTyTrYhSiOVwcDL4l9+8lKA7p
	1zBrFp3lBgk2fq5/ERAXFVeucRUA2HtaWGNVh9qsXZuvdT1+BCkvgP+V7E1Dv5bi
	t4cC4BcFMcLvH6dCmI5HHdgXZElrrZw2r243F6YbRQFsCHRHwsrQxTUEspNLLNF/
	aLcFBrcydfo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CB223265DC;
	Mon, 14 Jul 2014 11:54:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 40EBA265D9;
	Mon, 14 Jul 2014 11:54:39 -0400 (EDT)
In-Reply-To: <CACsJy8D0CdS5B5xNSSCk+LToXV9FnHFLkPzJ5f-7NTWiw9yn5w@mail.gmail.com>
	(Duy Nguyen's message of "Sun, 13 Jul 2014 12:09:25 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2975554C-0B6F-11E4-9E6E-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253495>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, Jul 12, 2014 at 11:44 AM, David Turner <dturner@twopensource.com> wrote:
>> @@ -342,6 +342,15 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
>>
>>                 discard_cache();
>>                 read_cache_from(index_lock.filename);
>> +               if (update_main_cache_tree(WRITE_TREE_SILENT) == 0) {
>> +                       fd = open(index_lock.filename, O_WRONLY);
>> +                       if (fd >= 0)
>> +                               if (write_cache(fd, active_cache, active_nr) == 0) {
>> +                                       close_lock_file(&index_lock);
>
> If write_cache() returns a negative value, index.lock is probably
> corrupted. Should we die() instead of moving on and returning
> index_lock.filename to the caller? The caller may move index.lock to
> index later on and officially ruin "index".

Perhaps true, but worse yet, this will not play nicely together with
your split index series, no?  After taking the lock and writing and
closing, we spawn the interactive while still holding the lock, and
the "open" we see here is because we want to further update the same
under the same lock.  Perhaps write_locked_index() API in the split
index series can notice that the underlying fd in index_lock has
been closed earlier, realize that the call is to re-update the
index under the same lock and open the file again for writing?

Then we can update the above "open() then write_cache()" sequence
with just a call to "write_locked_index()".
