From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Add an explicit GIT_DIR to the list of excludes
Date: Tue, 27 May 2014 11:04:23 -0700
Message-ID: <xmqqd2ezgkt4.fsf@gitster.dls.corp.google.com>
References: <1400866411-14584-1-git-send-email-pasha.bolokhov@gmail.com>
	<CACsJy8CDeTn8h8uUn_=6ek7BJueN_1i01TB_AeH03RKnf6tNSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pasha Bolokhov <pasha.bolokhov@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 20:04:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpLjn-0000hU-6z
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 20:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829AbaE0SEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 14:04:31 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56120 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751477AbaE0SE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 14:04:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 07F6D19AF1;
	Tue, 27 May 2014 14:04:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5Q4OsBcA9+m/GltYJ/FzDa45Eqs=; b=oi321D
	Jry6aABJzTcBg+bOaDKu3rS2vjwourNtxmAtEuohrMhm3mBvCyxBgPxoYoMwGRk4
	81d8p7JpwwMdTk0SfACVs/xZwlhsa7hGV2APmn9UMTOOG/8Lu3IEPQvzfVsXE+kz
	ol06wL/uhwn4pkYPZohivRwgVLCu1vE1wmRcI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WyBBo9kdTq/tGCG9ReQ/eMMhHym8XkKF
	u1nKPR/1X0YylKDk2WZ/OtbdoF+Bcm272WC8R6cimetXwqZGdfWm3ND/+xf/67xT
	vlgvoKviRvJu05Gi5gTbhiS8WT2N//lArp//zJz/pKrplXag1nN08rOVis1tC4MQ
	d2Np+I8gmwI=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F27DA19AF0;
	Tue, 27 May 2014 14:04:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A066919AEC;
	Tue, 27 May 2014 14:04:25 -0400 (EDT)
In-Reply-To: <CACsJy8CDeTn8h8uUn_=6ek7BJueN_1i01TB_AeH03RKnf6tNSw@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 24 May 2014 08:41:02 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 56AE279E-E5C9-11E3-92EA-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250178>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, May 24, 2014 at 12:33 AM, Pasha Bolokhov
> <pasha.bolokhov@gmail.com> wrote:
>> When an explicit '--git-dir' option points to a directory inside
>> the work tree, git treats it as if it were any other directory.
>> In particular, 'git status' lists it as untracked, while 'git add -A'
>> stages the metadata directory entirely
>>
>> Add GIT_DIR to the list of excludes in setup_standard_excludes(),
>> while checking that GIT_DIR is not just '.git', in which case it
>> would be ignored by default, and that GIT_DIR is inside GIT_WORK_TREE
>>
>> Although an analogous comparison of any given path against '.git'
>> is done in treat_path(), this does not seem to be the right place
>> to compare against GIT_DIR. Instead, the excludes provide an
>> effective mechanism of ignoring a file/directory, and adding GIT_DIR
>> as an exclude is equivalent of putting it into '.gitignore'. Function
>> setup_standard_excludes() was chosen because that is the place where
>> the excludes are initialized by the commands that are concerned about
>> excludes
>
> I like this approach. A search of "exclude-standard" in Documentation/
> gives git-grep.txt and git-ls-files.txt. I don't know if we need to
> add something about this extra exclude rule to those .txt. If it's so
> obvious that this should be the expected behavior, then probably not.

OK, so is that an Acked/Reviewed-by?

>
> The case of "git grep --exclude-standard" is interesting because it's
> intended to work without a repository. First reaction was would
> get_git_dir() return NULL in that case. But it should return ".git" so
> we're good.
