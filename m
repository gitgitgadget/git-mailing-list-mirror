From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'eol' documentation confusion
Date: Mon, 22 Jun 2015 09:11:55 -0700
Message-ID: <xmqqr3p3iuyc.fsf@gitster.dls.corp.google.com>
References: <CAHd499CapqvC3pHszgmX2VexdmqiW4+N23YfkAP5jjXWDrbe0A@mail.gmail.com>
	<CAHd499Do_bpdOkL2TqdO+8L=pR53117pKR0GSwdgvFDwq_S4=w@mail.gmail.com>
	<5587AAB2.80305@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 22 18:12:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z74KJ-0005yC-J5
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 18:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751807AbbFVQL7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Jun 2015 12:11:59 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:34658 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbbFVQL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 12:11:57 -0400
Received: by igboe5 with SMTP id oe5so67026933igb.1
        for <git@vger.kernel.org>; Mon, 22 Jun 2015 09:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type:content-transfer-encoding;
        bh=KuFLEqznM+CeKePND3ehazRdpyYYJALo9hdM85I0HJ8=;
        b=BE2Zx1eYq3/c0rSlk7kdbEDYF4HgMpVufUq/Gp28O7fMe9w9QqgwJow7wywgQPI1qV
         jjr+RxMaqHkVg+6OGvc7nd0ImgrW9RaKGd4K0fxN5RAcgBKsB+R01EuyXYheia9/W2hs
         actsvsKAoFahULxjqBruAAcOklKostJ7NXH1RE8jcVvYS9vaT2+A0dLzXtkIhpzixObz
         Amu+T8ocJWe+fILxs2EnOVPjAGTNkHT5OyAI7jO5qli8QEeMmk25e5euo3rT5y9xWgY+
         WOStinLPlNJ8+6f4wLeN9dpGT1VnsTnEA2aeG77RcUj7HZrJcJ/LMQMhUbBgnnJUSaH3
         xPEw==
X-Received: by 10.50.178.230 with SMTP id db6mr22064345igc.26.1434989517191;
        Mon, 22 Jun 2015 09:11:57 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b0be:ae3d:b206:8e25])
        by mx.google.com with ESMTPSA id h138sm13030196ioe.2.2015.06.22.09.11.56
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 22 Jun 2015 09:11:56 -0700 (PDT)
In-Reply-To: <5587AAB2.80305@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershausen?=
 =?utf-8?Q?=22's?= message of
	"Mon, 22 Jun 2015 08:26:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272393>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> eol=3Dlf or eol=3Dcrlf are the only useful settings.
> Everything else is ignored because it does not make sense.
>
> See convert.c:
> static enum eol git_path_check_eol()

That makes me wonder...

The original reasoning behind the current behaviour that we ignore
unknown values given to configuration variables and attributes is so
that people can use the same file that has values that are
understood by newer versions of Git with older versions of Git.

You may be trying the eol=3DcleverLF setting introduced in Git version
47-prerelease by adding it to .git/info/attributes, and may have
found it useful.  But you may also have to use the same repository
on another machine that you didn't install that future version of
Git over the network filesystem.  Barfing and not proceeding when we
see unknown eol=3DcleverLF does not sound like a nice thing to do,
which is why we just ignore and behave as if the setting was not
there.

Ideally, however, I think we should ignore an unknown setting as
long as it does not matter (i.e. we do not come to the codepath that
wants to know eol settings for the path, e.g. running "git log" to
show only the commit log messages and the topology of the history),
but we should error out when the unknown setting possibly matters
(i.e. we do need the eol setting for the path in order to correctly
convert the contents to end-user's liking).

Thoughts (and patches ;-)?
