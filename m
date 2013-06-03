From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 3/4] contrib: related: add option to parse from committish
Date: Mon, 03 Jun 2013 12:05:15 -0700
Message-ID: <7v8v2rdnh0.fsf@alter.siamese.dyndns.org>
References: <1369986380-412-1-git-send-email-felipe.contreras@gmail.com>
	<1369986380-412-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 21:05:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uja4M-0008Fe-TQ
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 21:05:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758064Ab3FCTFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 15:05:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62821 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757984Ab3FCTFU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 15:05:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F41424D11;
	Mon,  3 Jun 2013 19:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Pd0EoAfDlYkhYTkezeBcW/yc5+k=; b=IWSgeL
	Tvq2HUA0GVze7dbPzmIQQ8ujqUzwFtd3QZq03tooYyj4Tmr8bDMsU/Uoe/LOkfJn
	oIzJdykdmfcfCSXbES2fT9GjLLycGYwbhA+ueEUkgNOSHAo2gXzGj2tJU454n1/a
	5njubh4lMZqqRcS+LVzNfA8eA8cdFpsuzV5oA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CXmReBYSYju4zGrA0EIRNTUO3F+tM7pf
	ozSobcxmbe6qhoBC5z1+fZ+IAHkh/Rr0RKFGk0gFbmV8nSm/Bzpq3uFGTV1cFNrx
	gwTfCUFDSs3nqHM1+GnADjhwrznwnpOrZm24HfeYbqZ+vEQ+r3KEpcDthNj3ZaOX
	Bn00uFCQ6t8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C203924D0F;
	Mon,  3 Jun 2013 19:05:18 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B9DE24D0C;
	Mon,  3 Jun 2013 19:05:17 +0000 (UTC)
In-Reply-To: <1369986380-412-4-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Fri, 31 May 2013 02:46:19 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 87816678-CC80-11E2-99E1-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226265>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> For example master..feature-a.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/related/git-related | 38 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 36 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/related/git-related b/contrib/related/git-related
> index 3379982..20eb456 100755
> --- a/contrib/related/git-related
> +++ b/contrib/related/git-related
> @@ -1,10 +1,12 @@
>  #!/usr/bin/env ruby
>  
>  # This script finds people that might be interested in a patch
> -# usage: git related <files>
> +# usage: git related <files | rev-list options>
>  
>  $since = '5-years-ago'
>  $min_percent = 10
> +$files = []
> +$rev_args = []
>  
>  class Commit
>  
> @@ -102,10 +104,42 @@ class Commits
>      end
>    end
>  
> +  def from_rev_args(args)
> +    source = nil
> +    File.popen(%w[git rev-list --reverse] + args) do |p|
> +      p.each do |e|
> +        id = e.chomp
> +        @main_commits[id] = true
> +        File.popen(%w[git show -C --oneline] + [id]) do |p|

Is there a solid design choice behind -C, or is it just what happens
to have worked for you in practice?  If the former, it may want to
be explained somewhere (either in the log or in the code) so that
later tweaks will not break it, especially given that the invocation
of blame seems to use double-C's.

> +          p.each do |e|
> +            case e
> +            when /^---\s+(\S+)/
> +              source = $1 != '/dev/null' ? $1[2..-1] : nil
> +            when /^@@ -(\d+)(?:,(\d+))?/
> +              get_blame(source, $1, $2, id) if source
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
> +if $files.empty?
> +  commits.from_rev_args($rev_args)
> +else
> +  commits.from_patches($files)
> +end
>  commits.import
>  
>  count_per_person = Hash.new(0)
