From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/RFC] upload-pack: ignore 'shallow' lines with unknown obj-ids
Date: Sun, 21 Apr 2013 09:56:15 +1000
Message-ID: <CACsJy8CT8r7ebE_q5ET+oicTY0NM4LAt1B61xwqfL8tLKc-4OA@mail.gmail.com>
References: <CAJDSCnN6Ekp3wF9hX9Dbt3+CLNg1_aBz8nPGUuCu0WS9MF8aXA@mail.gmail.com>
 <CACsJy8B6OYC-Qcwc53BsVtUSHw1ag6LWF2rBSP6agO6yTXQo+g@mail.gmail.com> <7v7gjxx6w3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Heemskerk <mheemskerk@atlassian.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 01:56:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTheG-0003Wl-NF
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 01:56:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154Ab3DTX4r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 19:56:47 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:48590 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755958Ab3DTX4q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 19:56:46 -0400
Received: by mail-ob0-f172.google.com with SMTP id v19so4408721obq.3
        for <git@vger.kernel.org>; Sat, 20 Apr 2013 16:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Zls3OwPlpVZvcr+K2lfs/fqZe+ADRjeNcQHaZBGZu4Y=;
        b=WonEoJlWg+G8F2AirQesCV47SmNrt+Ii9ABPymsptPJ9sxtLsNSAcvTWnsrAIGWTy7
         ++DdtOz1x0F3HMExWRP0lXCYIwrHKw6s37csQqHO8K8IdgkL2Z+yQ9Pu4k/qE/bXds1w
         HuCfW0ZtK6XHLgISnhN7aJzxWVhZZGKT4Th5q2HseANT9NEK1+YfwEbx7/P7M7NC5iv2
         K8uOzULZqq6rZJo7hXrU3zfrJVyLSLjz5lnDZmx9M1SL5/aq+2Lpe26a5bDQB7ecaOW4
         QqISTXZtAT2cqKEkMp73rAWUW3s6eYdjlmdsIFdpQ4+i/V5wfiKD2YiWrfhH2KFn4K2T
         O1jg==
X-Received: by 10.60.135.103 with SMTP id pr7mr7162908oeb.142.1366502205571;
 Sat, 20 Apr 2013 16:56:45 -0700 (PDT)
Received: by 10.76.122.163 with HTTP; Sat, 20 Apr 2013 16:56:15 -0700 (PDT)
In-Reply-To: <7v7gjxx6w3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221883>

On Sun, Apr 21, 2013 at 6:51 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
> But the shallow list is also used to compute the updated boundary
> (i.e. "this client does not have a valid history behind these
> commits")?  When we know their current shallow boundary, after
> sending history that crosses that boundary, we can tell them "before
> this fetch, you did not have any history behind this commit, but we
> know that you now have a bit more. Update your record with these new
> boundaries. You still do not have any history behind these commits."
> That is how deepening works.
>
> When you receive a shallow boundary unknown to you, it might not
> hurt if you keep it and parrot it at the end, so that the fetcher
> will still remember that it does not have any history behind the
> commit.  There may be reasons why doing so is not sufficient and we
> have to reject clients whose history is truncated at a place unknown
> to us.
>
> You would declare "now you have everything behind that unknown
> shallow boundary", if you ignore an unknown shallow boundary and do
> not send it back.
>
> That sounds ourright wrong to me. You simply do not know enough to
> make such a declaration.

It's a good point. But I think the receiver does not rely solely on
"shallow " lines from the sender to create new shallow file. If it
receives "shallow " line, it registers the received sha-1 as a cut
point. If it receives "unshallow " line, it unregisters. If it
receives neither, the current registered cutpoints in memory are
simply written back to disk. So not sending it back should not be a
big problem (at least for C Git).

> I do not seem to find the patch you are responding to, so I do not
> know how the patch handled the unshallowing part, but the impression
> I got from reading the log message quoted is that the patch was not
> even aware of the issue.

I can't find it on gmane.org either. Patch quoted below.

On Sat, Apr 20, 2013 at 8:05 PM, Michael Heemskerk
<mheemskerk@atlassian.com> wrote:
> diff --git a/Documentation/technical/pack-protocol.txt
> b/Documentation/technical/pack-protocol.txt
> index f1a51ed..b898e97 100644
> --- a/Documentation/technical/pack-protocol.txt
> +++ b/Documentation/technical/pack-protocol.txt
> @@ -228,8 +228,7 @@ obtained through ref discovery.
>  The client MUST write all obj-ids which it only has shallow copies
>  of (meaning that it does not have the parents of a commit) as
>  'shallow' lines so that the server is aware of the limitations of
> -the client's history. Clients MUST NOT mention an obj-id which
> -it does not know exists on the server.
> +the client's history.
>
>  The client now sends the maximum commit history depth it wants for
>  this transaction, which is the number of commits it wants from the
> diff --git a/upload-pack.c b/upload-pack.c
> index bfa6279..127e59a 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -592,7 +592,7 @@ static void receive_needs(void)
>                                 die("invalid shallow line: %s", line);
>                         object = parse_object(sha1);
>                         if (!object)
> -                               die("did not find object for %s", line);
> +                               continue;
>                         if (object->type != OBJ_COMMIT)
>                                 die("invalid shallow object %s",
> sha1_to_hex(sha1));
>                         if (!(object->flags & CLIENT_SHALLOW)) {
> --
> 1.8.0.2
>
--
Duy
