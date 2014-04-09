From: Junio C Hamano <gitster@pobox.com>
Subject: On "interpret-trailers" standalone tool
Date: Wed, 09 Apr 2014 12:57:26 -0700
Message-ID: <xmqq61mi1djt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 09 21:57:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXycp-0006hh-Eq
	for gcvg-git-2@plane.gmane.org; Wed, 09 Apr 2014 21:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933603AbaDIT5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2014 15:57:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62314 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758279AbaDIT5a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2014 15:57:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0E767BE2C;
	Wed,  9 Apr 2014 15:57:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=Z
	VupG6df9uASoQCEJnD15pygbC8=; b=qKhaiCPq5hs+RtK3IwdExrgR0JAspL42I
	AB/zJs9jFIVA2Oe1SCpZRdLtByb2rWFUEgnV2NFDaZrOHS+6dy98X0WSfZLJw9YQ
	511wGR8eWBz+1f91qi48TpUqOPKgGuuVbzZq9XaU1Csh0pNNKOQJ0seLBYGja5sG
	8AW3kRNE98=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=TM4sr+UetmrrsZyw8O7oOyWKQQz8Oa2QDPdN8SF25/SG+k1JAlgW8GBb
	cfhwumagnoAPFpFJxiumQlQyGO8AZwcLYyR1vhAB1hFMzeRQ1gBeQSdaidJAiZNt
	AA6YaY38Cr/uKl09X2iuFoI5XrmA/FX8pH45KRlNzh4zk3GaHY4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BFF47BE2B;
	Wed,  9 Apr 2014 15:57:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 61BA17BE29;
	Wed,  9 Apr 2014 15:57:28 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2DAE1FDE-C021-11E3-AEB6-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245996>

So far I've mostly been ignoring how the command line would look
like, because the intermediate goal to my mind was to have it as a
hook that are added by people better versed with Git than an average
end-user, and if the command line interface had to change then they
are capable of updating it, so it is more acceptable than the usual
end-user tools to break compatibility between an early prototype and
later versions, and because the final goal would be to libify the
internal logic and integrate it into places we would invoke hooks,
making the standalone command irrelevant.

However, I started to care ;-)  For example, wouldn't it be nice if
you can do

    $ git format-patch -5 --cover-letter -o +my-series/ my-topic
    $ git interpret-trailers "some args" ./+my-series/0*.patch

to fix-up the "trailers" portion of the proposed log message in the
formatted patches?  There may be other possible uses that having a
standalone tool would be helpful, even after we removed the need for
such a tool from commit, rebase, etc. by integrating the internal
logic to the implementation of these commands.

However, I am wondering if the current "everything on the command
line is instruction to the command" is too limiting to allow the use
of the tool both as a filter and as a tool that can work on one or
more files named on the command line.  If we start from there, the
only way to later add "these arguments are names of the files to be
operated on" is to add "--file <file1> --file <file2>..." options,
which feels quite backwards as a UNIX tool.

It would be easier to explain and understand if the command line
option set is modeled after things like "cat" or "sed", where
non-option arguments are filenames, instructions are given in the
form of "--option <arg>" (e.g. "-e 's/foo/bar/'" given to sed), and
having no non-option arguments on the command line signals that the
tool is working as a filter.
