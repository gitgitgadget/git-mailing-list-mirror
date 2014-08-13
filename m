From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 1/2] git_default_config() rewritten using the config-set API
Date: Wed, 13 Aug 2014 10:18:40 -0700
Message-ID: <xmqq4mxg48b3.fsf@gitster.dls.corp.google.com>
References: <1407918122-29973-1-git-send-email-tanayabh@gmail.com>
	<vpqppg4vdii.fsf@anie.imag.fr> <53EB58A0.10307@gmail.com>
	<vpq4mxgtu07.fsf@anie.imag.fr> <53EB6914.2030807@gmail.com>
	<vpq1tsks7kg.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 13 19:18:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHcCM-00039m-VB
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 19:18:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753700AbaHMRSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 13:18:51 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53250 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753479AbaHMRSu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 13:18:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8535B30D35;
	Wed, 13 Aug 2014 13:18:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mM9JpPPPT4MOs85ba+hQIIMOL6E=; b=C21zeb
	n1sb1FqZA3APll9oIPvimpb0UOFCvbXNvfSNNmYGxFqvSrXWcB4fXAsWdCtDoyoG
	y0vGMLmoAbfFTUoNJ+AJUrmEiiPClmRDcSnGIyoPez3A98Cdkx/gAr9a6lLX0/9a
	5PDqbt9/x2/xFVhZLUkwSUJShsecnIxHrD9ZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rMjMZFFcJc9rBFoTEJxs/gvvf0ZCz1vP
	DaPwH56PGQPdBGoe084JBhJM2y3VtZCa/ci/M4Xmajy/18HT5KFmPpNdKPnMuhuo
	K55sqUgBeNhyDKgPSaivpdY5WuelcN9s/UqHE1yoe2cSfoVMBYmb5olK4g0XpJrs
	fGo3Kp+vumU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7B5A830D34;
	Wed, 13 Aug 2014 13:18:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 60C3930D2E;
	Wed, 13 Aug 2014 13:18:42 -0400 (EDT)
In-Reply-To: <vpq1tsks7kg.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	13 Aug 2014 18:00:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DFCA3456-230D-11E4-9447-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255219>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Tanay Abhra <tanayabh@gmail.com> writes:
>
>> git_default_config() now uses config-set API functions to query for
>> values.
>
> I believe you missed a few spots:
>
> $ git grep -n 'git_default_config[^(]'
> Documentation/user-manual.txt:4287:        git_config(git_default_config);
> archive.c:416:  git_config(git_default_config, NULL);
> builtin/config.c:577:           git_config(git_default_config, NULL);
> color.h:73: * if you are just going to change to git_default_config, too.
> fetch-pack.c:880:       git_config(git_default_config, NULL);
> http.c:393:     config.cascade_fn = git_default_config;
> rerere.c:580:   git_config(git_default_config, NULL);
> rerere.c:710:   git_config(git_default_config, NULL);
>
> The following ones should probably be rewritten too:
>
> archive.c:416:  git_config(git_default_config, NULL);
> builtin/config.c:577:           git_config(git_default_config, NULL);
> fetch-pack.c:880:       git_config(git_default_config, NULL);
> rerere.c:580:   git_config(git_default_config, NULL);
> rerere.c:710:   git_config(git_default_config, NULL);

For a one-person toy project it is OK to repurpose the existing
git_default_config() to do completely different thing and make it a
flag day to switch the entire codebase, but in a collaborative
environment where there may be multiple topics in flight, some of
which may be happening where you are not even aware of, it is better
to remove the existing git_default_config() and use a different name
for the different function you are introducing, to force new places
that expect the old git_default_config() to work as before to be
noticed with a linkage error.
