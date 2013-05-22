From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] Add new git-related helper to contrib
Date: Wed, 22 May 2013 12:23:21 -0700
Message-ID: <7vr4gyizti.fsf@alter.siamese.dyndns.org>
References: <1368978823-18247-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 22 21:23:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfEdG-0006yA-CH
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 21:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756613Ab3EVTXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 15:23:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33186 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756224Ab3EVTXY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 15:23:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C7F420904;
	Wed, 22 May 2013 19:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FFFKJWQH004fxNNn4K1ZjDp/J6w=; b=NcTCQo
	XEXP01KZ7b2rKcvr4iZONmdj7YiJJgIFSozaR0GKzU7wRd8QPHWkMeRjcJorvKc/
	x0xXU7MOpPZVoSejNzUTOy5P6facJ3wCfthRZEiLAY8826nq0wyKJJ7nduG3+6ZN
	KpeMiOo+/wkn4B0xKWIffhEOpNt6Gh5CfwPqk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pj9j6D+CWFDIoIoYMTokZlPKP98n6L4h
	hyOpXclyNUwcCSUKFHWbJJ9tod02EMa//fpwHTproVRSbrT1LavSriT5p9xdaPuW
	VZntTvsa1I58IJ2gmUrTh5NDNc0dpTX0730SYhITZ7rDiqx0kVoavNPcaB05QxA9
	D08TpTnW8Fw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F4AB20903;
	Wed, 22 May 2013 19:23:24 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6BA2C20901;
	Wed, 22 May 2013 19:23:23 +0000 (UTC)
In-Reply-To: <1368978823-18247-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Sun, 19 May 2013 10:53:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 11C6F796-C315-11E2-878E-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225185>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> diff --git a/contrib/related/git-related b/contrib/related/git-related
> new file mode 100755
> index 0000000..b96dcdd
> --- /dev/null
> +++ b/contrib/related/git-related
> @@ -0,0 +1,124 @@
> +#!/usr/bin/env ruby
> +
> +# This script finds people that might be interested in a patch
> +# usage: git related <file>
> +
> +$since = '5-years-ago'
> +$min_percent = 10
> +
> +def fmt_person(name, email)
> +  '%s <%s>' % [name, email]
> +end

Micronit.  I suspect you do not need this helper, unless later
patches start using it.

> +  def import
> +    return if @items.empty?
> +    File.popen(%w[git cat-file --batch], 'r+') do |p|
> +      p.write(@items.keys.join("\n"))
> +      p.close_write
> +      p.each do |line|
> +        if line =~ /^(\h{40}) commit (\d+)/
> +          id, len = $1, $2
> +          data = p.read($2.to_i)
> +          @items[id].parse(data)
> +        end
> +      end
> +    end
> +  end
> +
> +  def get_blame(source, start, len, from)
> +    return if len == 0
> +    len ||= 1
> +    File.popen(['git', 'blame', '--incremental', '-CCC',

I am torn on the hardcoded use of "-CCC" here.

Depending on the nature of the change in question, it may match well
or worse to what you are trying to find out.  When you are trying to
say "What were you smoking when you implemented this broken logic?",
using -C may be good, but when your question is "Even though all the
callers of this function live in that other file, somebody moved
this function that used to be file static in that file to here and
made it public. Why?", you do not want to use -C.

I am reasonably sure that in the finished code later in the series
it will become configurable, but a fallback default is better to be
not so expensive one.

> +               '-L', '%u,+%u' % [start, len],
> +               '--since', $since, from + '^',

Is "from" unconditionally set?

Perhaps that nil + '^' magically disappear and this code is relying
on that, but it smells like a too much magic to me.

> +               '--', source]) do |p|
> +      p.each do |line|
> +        if line =~ /^(\h{40})/
> +          id = $&
> +          @items[id] = Commit.new(id)
> +        end
> +      end
> +    end
> +  end
> +
> +  def from_patch(file)
> +    from = source = nil
> +    File.open(file) do |f|
> +      f.each do |line|
> +        case line
> +        when /^From (\h+) (.+)$/
> +          from = $1
> +        when /^---\s+(\S+)/
> +          source = $1 != '/dev/null' ? $1[2..-1] : nil
> +        when /^@@ -(\d+)(?:,(\d+))?/
> +          get_blame(source, $1, $2, from)
> +        end

Makes sense to start from the preimage so that you can find out who
wrote the original block of lines your patch is removing.

But then if source is /dev/null, wouldn't you be able to stop
without running blame at all?  You know the patch is creating a new
file at that point and there is nobody to point a finger at.

> +      end
> +    end
> +  end
> +
> +end
> +
> +exit 1 if ARGV.size != 1
> +
> +commits = Commits.new
> +commits.from_patch(ARGV[0])
> +commits.import
> +
> +count_per_person = Hash.new(0)
> +
> +commits.each do |id, commit|
> +  commit.persons.each do |person|
> +    count_per_person[person] += 1
> +  end
> +end
> +
> +count_per_person.each do |person, count|
> +  percent = count.to_f * 100 / commits.size
> +  next if percent < $min_percent
> +  puts person
> +end
