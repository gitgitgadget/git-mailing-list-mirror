From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git merge <tag>: Spawning an editor can't be disabled
Date: Thu, 9 Feb 2012 10:08:18 -0600
Message-ID: <20120209160803.GA5742@burratino>
References: <20120209153431.GA24033@godiug.sigxcpu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
X-From: git-owner@vger.kernel.org Thu Feb 09 17:08:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvWYD-00061n-Hf
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 17:08:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758077Ab2BIQIl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Feb 2012 11:08:41 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64759 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753222Ab2BIQI1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Feb 2012 11:08:27 -0500
Received: by yhoo21 with SMTP id o21so926366yho.19
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 08:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=t1Z3vLKyi+R0qxkE4RCC+1IgEFACrfuRNqTpoi3bZjc=;
        b=dz8rdEgRoy6zTz3Ob4CBlW721CTPS480JnFm6ySg0GnNlPUgeh0YGSslDEAf7Ieue/
         xRqF7jxal4piiOdodPAbEQIiy8J4FAoXwjY+uBAG08D+TRap7nsFg1pen5Pu/HKwS4RD
         ezJuBpnwgqVmCOt8dk4krxVXrjDkAhSp3eJXs=
Received: by 10.50.236.5 with SMTP id uq5mr31756444igc.13.1328803706405;
        Thu, 09 Feb 2012 08:08:26 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id wn6sm5777236igb.3.2012.02.09.08.08.24
        (version=SSLv3 cipher=OTHER);
        Thu, 09 Feb 2012 08:08:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120209153431.GA24033@godiug.sigxcpu.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190295>

Hi,

Guido G=C3=BCnther wrote[1]:

> as of 1.7.9 merging in a tag unconditionally spawns an editor. I trie=
d
> turning this of with --no-edit but to no avail. This is a behaviour
> change that breaks tools like git-buildpackage. I wonder if this shou=
ld
> be turned off by default?

Thanks.  I can confirm this: ever since commit fab47d05 (merge: force
edit and no-ff mode when merging a tag object, 2011-11-07), running
"git checkout github/maint-1.5.6 && git merge --no-edit v1.7.2"
launches an editor window despite the caller's request.  And I agree
that it is counter-intuitive.

Here's a quick band-aid.  Unlike the case of [2], this does not
suppress the pulling-signed-tag magic when it kicks in, so the
resulting commit will record the signature and message of the tag you
merged, even though you have not carefully looked it over.  Not sure
if that's a good or bad thing yet.

Patch relies on "merge: use editor by default in interactive sessions"
from master.  If this looks like a sane approach, I can resend with a
proposed log message and a test for t/t7600-merge.sh.  (Or if someone
else wants to do it first, even better.)

Hmm?
Jonathan

[1] http://bugs.debian.org/659255
[2] http://thread.gmane.org/gmane.comp.version-control.git/189825/focus=
=3D189989

diff --git i/builtin/merge.c w/builtin/merge.c
index 62c7b681..c401106e 100644
--- i/builtin/merge.c
+++ w/builtin/merge.c
@@ -1323,7 +1323,8 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 		if (merge_remote_util(commit) &&
 		    merge_remote_util(commit)->obj &&
 		    merge_remote_util(commit)->obj->type =3D=3D OBJ_TAG) {
-			option_edit =3D 1;
+			if (option_edit < 0)
+				option_edit =3D 1;
 			allow_fast_forward =3D 0;
 		}
 	}
