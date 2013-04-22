From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 15/16] remote-hg: use marks instead of inlined files
Date: Mon, 22 Apr 2013 15:33:17 -0700
Message-ID: <7v1ua2nqky.fsf@alter.siamese.dyndns.org>
References: <1366667724-567-1-git-send-email-felipe.contreras@gmail.com>
	<1366667724-567-16-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Simon Ruderich <simon@ruderich.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 00:33:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUPIa-0003AS-BS
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 00:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753615Ab3DVWdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 18:33:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52485 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753348Ab3DVWdU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 18:33:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD53C18432;
	Mon, 22 Apr 2013 22:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P+DVvovhqOUo2tMJ9XtOtambyNw=; b=Chgc0a
	aHK7j/KsSaWPVa+WsXG3OkHjT376Qzw0otJ21sw+vsUjBNNiqaK1aNdml4L4hxHD
	cZ2CJVVvuJqDBweKSdRcmNVKJP0ze1AaNUT6iig0KRaS7dTsaKCkGg12SMxnSZoH
	59iGYNLzyvf7qJV/r9KdeSfIvLAKPoiZRihpg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YLNaAHBgR6VbrAJyHoDWxEi95UU60i8D
	n3AQm4v2xjy9kTbtPtjJi64TkijJOLuTBzDmF7d5yKIZVmjPv/ZbQq47h50HGaED
	1fVb0TgUicQSJSq4F3/FM1RmBoj7D8SxWs6nqDsiPVl6YZFFE2DPhltwyMm5GP/T
	7TUe1Zihn1k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A498018431;
	Mon, 22 Apr 2013 22:33:19 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC93418430;
	Mon, 22 Apr 2013 22:33:18 +0000 (UTC)
In-Reply-To: <1366667724-567-16-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Mon, 22 Apr 2013 16:55:23 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A191B75C-AB9C-11E2-ADC3-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222121>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> So that we can find already exported ones. We can never be 100% sure
> that we already exported such data, due to mercurial design, it at least
> sometimes we should detect them, and so should give ups some performance

s/ups/us/ (will locally tweak).

> boost.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/remote-helpers/git-remote-hg | 41 +++++++++++++++++++++++++++++-------
>  1 file changed, 33 insertions(+), 8 deletions(-)
>
> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
> index f80236b..d0e552c 100755
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -126,6 +126,10 @@ class Marks:
>      def to_rev(self, mark):
>          return self.rev_marks[mark]
>  
> +    def next_mark(self):
> +        self.last_mark += 1
> +        return self.last_mark
> +
>      def get_mark(self, rev):
>          self.last_mark += 1
>          self.marks[str(rev)] = self.last_mark
> @@ -218,12 +222,29 @@ def fix_file_path(path):
>          return path
>      return os.path.relpath(path, '/')
>  
> -def export_file(fc):
> -    d = fc.data()
> -    path = fix_file_path(fc.path())
> -    print "M %s inline %s" % (gitmode(fc.flags()), path)
> -    print "data %d" % len(d)
> -    print d
> +def export_files(files):
> +    global marks, filenodes
> +
> +    final = []
> +    for f in files:
> +        fid = node.hex(f.filenode())
> +
> +        if fid in filenodes:
> +            mark = filenodes[fid]
> +        else:
> +            mark = marks.next_mark()
> +            filenodes[fid] = mark
> +            d = f.data()
> +
> +            print "blob"
> +            print "mark :%u" % mark
> +            print "data %d" % len(d)
> +            print d
> +
> +        path = fix_file_path(f.path())
> +        final.append((gitmode(f.flags()), mark, path))
> +
> +    return final
>  
>  def get_filechanges(repo, ctx, parent):
>      modified = set()
> @@ -413,6 +434,8 @@ def export_ref(repo, name, kind, head):
>          if len(parents) == 0 and rev:
>              print 'reset %s/%s' % (prefix, ename)
>  
> +        modified_final = export_files(c.filectx(f) for f in modified)
> +
>          print "commit %s/%s" % (prefix, ename)
>          print "mark :%d" % (marks.get_mark(rev))
>          print "author %s" % (author)
> @@ -425,8 +448,8 @@ def export_ref(repo, name, kind, head):
>              if len(parents) > 1:
>                  print "merge :%s" % (rev_to_mark(parents[1]))
>  
> -        for f in modified:
> -            export_file(c.filectx(f))
> +        for f in modified_final:
> +            print "M %s :%u %s" % f
>          for f in removed:
>              print "D %s" % (fix_file_path(f))
>          print
> @@ -878,6 +901,7 @@ def main(args):
>      global peer, mode, bad_mail, bad_name
>      global track_branches, force_push, is_tmp
>      global parsed_tags
> +    global filenodes
>  
>      alias = args[1]
>      url = args[2]
> @@ -921,6 +945,7 @@ def main(args):
>      parsed_refs = {}
>      marks = None
>      parsed_tags = {}
> +    filenodes = {}
>  
>      repo = get_repo(url, alias)
>      prefix = 'refs/hg/%s' % alias
