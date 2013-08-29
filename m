From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-hg: support for notes
Date: Thu, 29 Aug 2013 15:12:34 -0700
Message-ID: <xmqqzjs016zx.fsf@gitster.dls.corp.google.com>
References: <xmqqa9k049qc.fsf@gitster.dls.corp.google.com>
	<1377813000-24465-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 30 00:12:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFASK-00073R-Ie
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 00:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536Ab3H2WMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 18:12:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45744 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751838Ab3H2WMk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 18:12:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A66C3DA74;
	Thu, 29 Aug 2013 22:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4KV+Pq6MMdolUskasDWo5RO+IVc=; b=yQjCAy
	ct3RDlNeWgELOjeyLFESddNB48Kll6Jsn+rdjayuiNjYm0gV8FVnNW34eTqfK7RY
	5yYtmgo7QKTPuIm6GVCNHDw/mH4SMIeFrPivVtom4YqT3FtjfXCzAQXv+OZ/sfAh
	i9zqxriHvG2ieh2fHe+vBgrzmQ8WDbhj2YT2A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hz+vJlWGnZeW0tjMaLWBuPGb64PcfaC8
	+TBbqkYmj9gVpUHbvucKfVyV2MsFXggd2zmXPLrkd+IwTxayy3z4+upv4zvPmCFK
	PqLf+yz8LXODphDkMpEeNkA9PBwVlKTsTP9URCPwSk3vUHdmoe2nkvAFlZzouuap
	KNWan/idnO8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A1483DA73;
	Thu, 29 Aug 2013 22:12:39 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F4693DA70;
	Thu, 29 Aug 2013 22:12:37 +0000 (UTC)
In-Reply-To: <1377813000-24465-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Thu, 29 Aug 2013 16:50:00 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1D34E9AE-10F8-11E3-9BF9-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233374>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

I somehow find this way under-explained to be useful for its users.

Is it clear what "support for notes" means in the context of
remote-hg?  Do we send data stored in our notes when we push back to
Hg?  Does Hg have a mechanism to store additional data out of band,
and we add notes when we pull from Hg?  Or does this "support" do
something else, and if so what does it do?

>  contrib/remote-helpers/git-remote-hg | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
> index 307d82c..e49fcfa 100755
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -23,6 +23,7 @@ import subprocess
>  import urllib
>  import atexit
>  import urlparse, hashlib
> +import time as ptime
>  
>  #
>  # If you are not in hg-git-compat mode and want to disable the tracking of
> @@ -126,6 +127,7 @@ class Marks:
>          self.rev_marks = {}
>          self.last_mark = 0
>          self.version = 0
> +        self.last_note = 0
>  
>      def load(self):
>          if not os.path.exists(self.path):
> @@ -137,6 +139,7 @@ class Marks:
>          self.marks = tmp['marks']
>          self.last_mark = tmp['last-mark']
>          self.version = tmp.get('version', 1)
> +        self.last_note = tmp.get('last-note', 0)
>  
>          for rev, mark in self.marks.iteritems():
>              self.rev_marks[mark] = rev
> @@ -150,7 +153,7 @@ class Marks:
>          self.version = 2
>  
>      def dict(self):
> -        return { 'tips': self.tips, 'marks': self.marks, 'last-mark' : self.last_mark, 'version' : self.version }
> +        return { 'tips': self.tips, 'marks': self.marks, 'last-mark' : self.last_mark, 'version' : self.version, 'last-note' : self.last_note }
>  
>      def store(self):
>          json.dump(self.dict(), open(self.path, 'w'))
> @@ -525,6 +528,31 @@ def export_ref(repo, name, kind, head):
>      print "from :%u" % rev_to_mark(head)
>      print
>  
> +    pending_revs = set(revs) - notes
> +    if pending_revs:
> +        note_mark = marks.next_mark()
> +        ref = "refs/notes/hg"
> +
> +        print "commit %s" % ref
> +        print "mark :%d" % (note_mark)
> +        print "committer remote-hg <> %s" % (ptime.strftime('%s %z'))
> +        desc = "Notes for %s\n" % (name)
> +        print "data %d" % (len(desc))
> +        print desc
> +        if marks.last_note:
> +            print "from :%u" % marks.last_note
> +
> +        for rev in pending_revs:
> +            notes.add(rev)
> +            c = repo[rev]
> +            print "N inline :%u" % rev_to_mark(c)
> +            msg = c.hex()
> +            print "data %d" % (len(msg))
> +            print msg
> +        print
> +
> +        marks.last_note = note_mark
> +
>      marks.set_tip(ename, head.hex())
>  
>  def export_tag(repo, tag):
> @@ -1126,6 +1154,7 @@ def main(args):
>      global filenodes
>      global fake_bmark, hg_version
>      global dry_run
> +    global notes, alias
>  
>      alias = args[1]
>      url = args[2]
> @@ -1165,6 +1194,7 @@ def main(args):
>      except:
>          hg_version = None
>      dry_run = False
> +    notes = set()
>  
>      repo = get_repo(url, alias)
>      prefix = 'refs/hg/%s' % alias
