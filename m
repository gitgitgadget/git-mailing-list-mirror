From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pass transport verbosity down to git_connect
Date: Thu, 28 Jan 2016 19:19:30 -0800
Message-ID: <xmqqpowljcn1.fsf@gitster.mtv.corp.google.com>
References: <20160128225123.GA20045@dcvr.yhbt.net>
	<20160128235339.GB10308@sigill.intra.peff.net>
	<20160129003816.GA26200@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Jan 29 04:19:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOzaz-0002rY-Hf
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 04:19:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012AbcA2DTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 22:19:33 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50399 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751403AbcA2DTc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 22:19:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3B7074020B;
	Thu, 28 Jan 2016 22:19:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xxHb9ZGO0V9jGePU26uTnsRd2+U=; b=N5t9c0
	4xrg5AVCjss8ETfuQyVs50ZDdCmqStKi3YEkUtJBswZslzshQfHJqu4VnBgYpthO
	XEimF0oFG6LO3eUAYop5sdweFY9IpHBjeV2B5xj2gElMA85Zl2zM1XdDTBNltAUa
	x+UMC+kNru1nvt11HbsY90IchK9NzfSv0nVns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wo0bWZs1rNfLFVa/ROW3SGPUzroFzeSp
	eMHKwIKVG2qX4GYU7BHbZcCSJi25fJmPZb5Wa7Np1GPn3aHZoXizZ/V/1La+ZdoZ
	14lr0TB9O8t5owbdBDdkFi3HywQ95nh/jcUSg+hkOiK65phgF/jyvqTNycH75UFJ
	HZlRJOnkEsU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3327A4020A;
	Thu, 28 Jan 2016 22:19:32 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A759940209;
	Thu, 28 Jan 2016 22:19:31 -0500 (EST)
In-Reply-To: <20160129003816.GA26200@dcvr.yhbt.net> (Eric Wong's message of
	"Fri, 29 Jan 2016 00:38:16 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1D04712E-C637-11E5-A252-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285058>

Eric Wong <normalperson@yhbt.net> writes:

> On the other hand, I'm not sure if there's anything parsing the stderr
> out of "git fetch -v" right now.

It would also affect end-user experience, depending on what new
pieces of lines are emitted to the terminal.  From "git fetch -v", I
expect to see the transfer progress and the final listing of fetched
and updated refs, and as long as the line "remote: Compressing
objects" and the lines that follow do not get garbled, I would
imagine it would be fine.

  ...
  remote: Compressing objects: 100% (1195/1195), done.
  remote: Total 1869 (delta 1551), reused 841 (delta 672)
  Receiving objects: 100% (1869/1869), 462.80 KiB | 0 bytes/s, done.
  Resolving deltas: 100% (1551/1551), completed with 335 local objects.
  From $over_there
   * branch            pu         -> FETCH_HEAD

>  In that case, perhaps only changing
> "-vv" (and documenting it) is a better idea.

I just reviewed the output that are protected by CONNECT_VERBOSE;
they look somewhere between pure debugging aid (like the protocol
dump that are shown by "fetch -vv") and progress display, and at
least to me they are much closer to the latter than the former, in
the sense that they are not _so_ annoying as the protocol dump that
are clearly not meant for the end users, and that they say "I am
looking up this host's address", "Now connecting to this host:port",
etc.

So, I personally find this addtional output not _too_ bad if we give
it with "fetch -v" (not limiting to "fetch -vv").

I dunno.
