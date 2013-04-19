From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/8] contrib: cc-cmd: add option to parse from committish
Date: Fri, 19 Apr 2013 10:59:50 -0700
Message-ID: <7vtxn21jvt.fsf@alter.siamese.dyndns.org>
References: <1366348458-7706-1-git-send-email-felipe.contreras@gmail.com>
	<1366348458-7706-6-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 20:00:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTFbP-0000uR-AC
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 20:00:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752887Ab3DSR74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 13:59:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51043 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752883Ab3DSR7z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 13:59:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A399017ABC;
	Fri, 19 Apr 2013 17:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WMEPuj4VhoNl7xWfOsXVRuHpMTo=; b=U+d8tF
	+e7azmrszwAhzJ13Wbe984jFqGDI0OXznvSbgD0Flc4+XGLkdLkylKN0PDzlkWVy
	nW8tPRwEQWnoo4UmDZV9BtAvEHOQerHa+rIUdL7H0YFZ5XsphVvLGIWycl1QTS6Y
	nQLAni1iR0rDjGVzT0+waSLAs45L+nqba6mAY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P+LhdVRRsxtbnbe0VVg5y+7qpVbnEAhs
	FfAsGhdXJ3XJzbJ7c69zTJCiwkEFzJwx/tqLhMTDoaL5TTtaT8DelvYO6dOdGxrB
	NM7L5KWgFHE/PiTl/W4X1UGO7Hn0IafidvYzdntvaKyg199IrGAgdEdOidfWqZrQ
	4y+G1SY8v8w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A18117ABA;
	Fri, 19 Apr 2013 17:59:53 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7B7E217AB8;
	Fri, 19 Apr 2013 17:59:52 +0000 (UTC)
In-Reply-To: <1366348458-7706-6-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Fri, 19 Apr 2013 00:14:15 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EF64C548-A91A-11E2-A203-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221788>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> For example master..feature-a.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/cc-cmd/git-cc-cmd | 36 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/cc-cmd/git-cc-cmd b/contrib/cc-cmd/git-cc-cmd
> index f13ed8f..462f22c 100755
> --- a/contrib/cc-cmd/git-cc-cmd
> +++ b/contrib/cc-cmd/git-cc-cmd
> @@ -5,11 +5,13 @@ require 'optparse'
>  $since = '3-years-ago'
>  $min_percent = 5
>  $show_commits = false
> +$files = []
> +$rev_args = []
>  
>  begin
>    OptionParser.new do |opts|
>      opts.program_name = 'git cc-cmd'
> -    opts.banner = 'usage: git cc-cmd [options] <files>'
> +    opts.banner = 'usage: git cc-cmd [options] <files | rev-list options>'
>  
>      opts.on('-p', '--min-percent N', Integer, 'Minium percentage of role participation') do |v|
>        $min_percent = v
> @@ -134,10 +136,40 @@ class Commits
>      end
>    end
>  
> +  def from_rev_args(args)
> +    return if args.empty?
> +    source = nil
> +    File.popen(%w[git rev-list --reverse] + args) do |p|
> +      p.each do |e|
> +        id = e.chomp
> +        @main_commits[id] = true
> +        File.popen(%w[git --no-pager show -C --oneline] + [id]) do |p|

When you know you are sending its output to a pipe, does --no-pager matter,
or is there anything more subtle going on here?

An extra --no-pager does not hurt, but it just caught/distracted my
attention while reading this patch.

> +          p.each do |e|
> +            case e
> +            when /^---\s+(\S+)/
> +              source = $1 != '/dev/null' ? $1[2..-1] : nil
> +            when /^@@\s-(\d+),(\d+)/
> +              get_blame(source, $1, $2, id)
> +            end
> +          end
> +        end
> +      end
> +    end
> +  end
> +
> +end
> +
> +ARGV.each do |e|
> +  if File.exists?(e)
> +    $files << e
> +  else
> +    $rev_args << e
> +  end
>  end
>  
>  commits = Commits.new
> -commits.from_patches(ARGV)
> +commits.from_patches($files)
> +commits.from_rev_args($rev_args)
>  commits.import
>  
>  if $show_commits
