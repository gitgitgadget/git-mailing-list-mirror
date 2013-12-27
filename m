From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-svn: workaround for a bug in svn serf backend
Date: Fri, 27 Dec 2013 14:22:57 -0800
Message-ID: <7veh4yj5mm.fsf@alter.siamese.dyndns.org>
References: <20131226202805.GV20443@google.com>
	<1388131515-3015-1-git-send-email-rkagan@mail.ru>
	<20131227200708.GD20443@google.com>
	<20131227203443.GA9189@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Roman Kagan <rkagan@mail.ru>,
	git@vger.kernel.org, Benjamin Pabst <benjamin.pabst85@gmail.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Dec 27 23:22:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vwfo1-0000ih-8i
	for gcvg-git-2@plane.gmane.org; Fri, 27 Dec 2013 23:22:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754843Ab3L0WWx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Dec 2013 17:22:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56058 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754821Ab3L0WWw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Dec 2013 17:22:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C47D5CE55;
	Fri, 27 Dec 2013 17:22:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6S/sKomoj/ilWyS/EfLuqNxW+vU=; b=t6sLaF
	Bein7QZtaQeUjZORfJ4U/XLQ2tTAUIPDn7xoAh/+GsHMyjNvbc1ZnBbbmgaMhvgg
	sWOAgtDyMAz3vNyGq8UR4Ux5uUbzg62F1nXmTX86LZn7w7T2aT0m4LhVyZLfWKKR
	ovDfYWpwomoeJO577DzFq3dI1ozhgFbT5WM5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lcC2YihropQwrFYHDf3Lj6dY/K8EwLiX
	4N/cuInZMZWdt17v1YLJ6M9K7gfDTQthhViZKypLxk6lLge+9VAFkA9hSs39r07Y
	lvjgPB0JqchalxuQAvP/j8tGzY2RvHGfZy4UtQUyuk/ZizAszwxrSWXMwCuATC6S
	i6nhoIzPxSs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C8815CE54;
	Fri, 27 Dec 2013 17:22:52 -0500 (EST)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 361B15CE53;
	Fri, 27 Dec 2013 17:22:51 -0500 (EST)
In-Reply-To: <20131227203443.GA9189@dcvr.yhbt.net> (Eric Wong's message of
	"Fri, 27 Dec 2013 20:34:43 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: 6C6A955E-6F45-11E3-A75F-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239753>

Eric Wong <normalperson@yhbt.net> writes:

> Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Roman Kagan wrote:
>> 
>> > Subversion serf backend in versions 1.8.5 and below has a bug that the
>> > function creating the descriptor of a file change -- add_file() --
>> > doesn't make a copy of its third argument when storing it on the
>> > returned descriptor.  As a result, by the time this field is used (in
>> > transactions of file copying or renaming) it may well be released, and
>> > the memory reused.
>> >
>> > One of its possible manifestations is the svn assertion triggering on an
>> > invalid path, with a message
>> >
>> > svn_fspath__skip_ancestor: Assertion `svn_fspath__is_canonical(child_fspath)' failed.
>> [...]
>> 
>> Makes sense.  Perhaps also worth mentioning that this is fixed by
>> r1553376, but no need to reroll just for that.
>
> Thanks all, I noted this in an addendum to the commit:
>
>     Subversion serf backend in versions 1.8.5 and below has a bug(*) that the
>
>     ...
>
>     * [ew: fixed in Subversion r1553376 as noted by Jonathan Nieder]
>
>> > Cc: Benjamin Pabst <benjamin.pabst85@gmail.com>
>> > Cc: Eric Wong <normalperson@yhbt.net>
>> > Cc: Jonathan Nieder <jrnieder@gmail.com>
>> 
>> No need for these lines --- the mail header already keeps track of who
>> is being cc-ed.
>
> I don't mind seeing it in history.  At least I've gotten accustomed to
> it from the Linux kernel and tracking patch flow between dev -> stable
> trees.
>
>> > Signed-off-by: Roman Kagan <rkagan@mail.ru>
>> 
>> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
>
>
> The following changes since commit 7794a680e63a2a11b73cb1194653662f2769a792:
>
>   Sync with 1.8.5.2 (2013-12-17 14:12:17 -0800)
>
> are available in the git repository at:
>
>
>   git://git.bogomips.org/git-svn.git master
>
> for you to fetch changes up to 2394e94e831991348688831a384b088a424c7ace:
>
>   git-svn: workaround for a bug in svn serf backend (2013-12-27 20:22:19 +0000)
>
> ----------------------------------------------------------------
> Roman Kagan (1):
>       git-svn: workaround for a bug in svn serf backend
>
>  perl/Git/SVN/Editor.pm | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Thanks. I almost missed this pull-request, though.

Will pull.
