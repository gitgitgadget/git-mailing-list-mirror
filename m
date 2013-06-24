From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: give early feedback
Date: Mon, 24 Jun 2013 11:24:46 -0700
Message-ID: <7vzjuf8iz5.fsf@alter.siamese.dyndns.org>
References: <1372095662-24527-1-git-send-email-artagnon@gmail.com>
	<20130624180419.GC26287@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 20:24:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrBRd-00009C-KJ
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 20:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753234Ab3FXSYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 14:24:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37785 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753194Ab3FXSYs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 14:24:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FA362B990;
	Mon, 24 Jun 2013 18:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JbNhYLtQ6G2bdzK2jcNkOy5+S68=; b=FdPGO8
	Tlnm9qT3yJaJndYvuY714isAnsx7voqanO6Vkt1uVjpTpf9Eofzqz7s/k0pUrrgA
	nu4ouqCSm1pUhQVzP+rkGfKiL3ZjTPCjuMOx8m9saVUw1hpmzZz0+51xs0+NQ7yt
	3XvL4/O0+491atQSzhsa0KMx/TKvfg9BtfiUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DQs+Y4ndwLszTXuEY/Ot4fOgKcz3kaAR
	87UjtWJMj7CLPg8ufDcGqGgucEFfm1x1EV2vVYxT+8pdwXOOcoIGKdwir3R8IIgU
	9OQN6MqmV6zHbmAPV+58SRqQIDR7btKY/jIQqo1qGIV0Sp6GtSWxGMZ0u0y8FGmp
	z6FmLUClM4c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 756052B98F;
	Mon, 24 Jun 2013 18:24:48 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CEB402B98C;
	Mon, 24 Jun 2013 18:24:47 +0000 (UTC)
In-Reply-To: <20130624180419.GC26287@paksenarrion.iveqy.com> (Fredrik
	Gustafsson's message of "Mon, 24 Jun 2013 20:04:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 59F33F0C-DCFB-11E2-A34C-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228891>

Fredrik Gustafsson <iveqy@iveqy.com> writes:

> On Mon, Jun 24, 2013 at 11:11:02PM +0530, Ramkumar Ramachandra wrote:
>> There are many configuration variables that determine exactly what a
>> push does.  Give the user early feedback so that she has a chance to
>> abort if she doesn't mean to push those refspecs to that destination
>> like:
>> 
>>   $ git push
>>   # pushing refspecs 'master next' to ram (^C to abort)
>> 
>> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
>> ---
>>  Goes without saying: this is an early preview.
>> 
>>  builtin/push.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>> 
>> diff --git a/builtin/push.c b/builtin/push.c
>> index 2d84d10..085d5ab 100644
>> --- a/builtin/push.c
>> +++ b/builtin/push.c
>> @@ -330,6 +330,7 @@ static int do_push(const char *repo, int flags)
>>  {
>>  	int i, errs;
>>  	struct remote *remote = pushremote_get(repo);
>> +	struct strbuf sb = STRBUF_INIT;
>>  	const char **url;
>>  	int url_nr;
>>  
>> @@ -375,6 +376,11 @@ static int do_push(const char *repo, int flags)
>>  	}
>>  	errs = 0;
>>  	url_nr = push_url_of_remote(remote, &url);
>> +
>> +	for (i = 0; i < refspec_nr; i++)
>> +		strbuf_addf(&sb, "%s%s", refspec[i], i == refspec_nr - 1 ? "": " ");
>> +	printf("# pushing refspecs '%s' to %s (^C to abort)\n", sb.buf, remote->name);
>> +
>
> How about a strbuf_release here?
>
> Can you really be sure that refspec_nr is set here?

Doing this unconditionally when the user says "git push there this"
would be mildly annoying.

I think this belongs to either --verbose or even --debug, for people
who are trying to make sure an underspecified "git push" (or "git
push there") does what they want, but for those use cases, it
probably is better to tie this to --dry-run.
