From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 05/13] Drive the debug editor
Date: Wed, 7 Jul 2010 13:26:31 -0500
Message-ID: <20100707182631.GB2617@burratino>
References: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
 <1278461693-3828-6-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>, dev@subversion.apache.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 07 20:27:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWZLA-0003fF-1T
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 20:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756064Ab0GGS1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 14:27:16 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51266 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754926Ab0GGS1P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 14:27:15 -0400
Received: by iwn7 with SMTP id 7so8105074iwn.19
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 11:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=FKeU4TbFlLkJzdauC29V0dBiCMSzN5UnnTcbSx8zrms=;
        b=Zh5aWwKKI/7l/QtF7Ii3GzXNoAibUIKqT+sQ6ByfacSC7iWspmaQkFE3iKrC+4FJEs
         avCFkh5oVYDSDDXrT7y/B+FRzFR1EON5m52byoEVLh2N1n/VXceA5hnKATjI4Y0mJ0sF
         nQEQV1IlzyvFXYYTRod0+GcWAyLp5zuWtWwRc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PuTBzQ+IuysBqsDkcz2nIf88P1DwLuQyW63AANPj4LYTZ8NpIlbzfT78sz+Xn5sqWm
         8PMTeV1ANYbU9+UVgg17xnuyOSIVv16iyDihY8vyvgaYouIX648+tJ27ovMbgdDHEeKu
         HWtsUrPpLe2KtCKQJGICPmFCENw/hy8dCcL6E=
Received: by 10.231.185.142 with SMTP id co14mr7122000ibb.97.1278527231594;
        Wed, 07 Jul 2010 11:27:11 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 34sm29897797ibi.0.2010.07.07.11.27.10
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 07 Jul 2010 11:27:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1278461693-3828-6-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150492>

Ramkumar Ramachandra wrote:

> +++ b/dump_editor.c
> @@ -128,7 +128,7 @@ svn_error_t *get_dump_editor(const svn_delta_editor_t **editor,
>  	de->close_directory = close_directory;
>  	de->change_dir_prop = change_dir_prop;
>  	de->change_file_prop = change_file_prop;
> -	de->apply_textdelta = apply_textdelta;
> +	/* de->apply_textdelta = apply_textdelta; */

Hmm...

[...]
> +++ b/dumpr_util.h
> @@ -1,6 +1,11 @@
>  #ifndef DUMPR_UTIL_H_
>  #define DUMPR_UTIL_H_
>  
> +struct replay_baton {
> +	const svn_delta_editor_t *editor;
> +	void *baton;
> +};
> +

Context during svnsync-like replay ops:

 - a diff replayer
 - its context object

Maybe "void *edit_baton" would be clearer.

>  struct edit_baton {

Which might involve renaming this to dump_edit_baton to avoid
confusion.

> +++ b/svndumpr.c
> @@ -8,10 +8,40 @@
[...]
> +static svn_error_t *replay_revstart(svn_revnum_t revision,
> +                                    void *replay_baton,
> +                                    const svn_delta_editor_t **editor,
> +                                    void **edit_baton,
> +                                    apr_hash_t *rev_props,
> +                                    apr_pool_t *pool)

This function is called to acquire an editor to replay one revision.

> +{
> +	/* Extract editor and editor_baton from the replay_baton and
> +	   set them so that the editor callbacks can use them */

This comment just paraphrases the code.  What in particular requires
explanation here?

> +	struct replay_baton *rb = replay_baton;
> +	*editor = rb->editor;
> +	*edit_baton = rb->baton;
> +
> +	return SVN_NO_ERROR;
> +}

[...]
> @@ -47,6 +77,25 @@ svn_error_t *open_connection(const char *url)
>  
>  svn_error_t *replay_range(svn_revnum_t start_revision, svn_revnum_t end_revision)
>  {
[...]
> +	SVN_ERR(svn_cmdline_printf(pool, SVN_REPOS_DUMPFILE_MAGIC_HEADER ": %d\n",
> +				   SVN_REPOS_DUMPFILE_FORMAT_VERSION));

Did this sneak in from a later patch?

> +	SVN_ERR(svn_ra_replay_range(session, start_revision, end_revision,
> +	                            0, TRUE, replay_revstart, replay_revend,
> +	                            replay_baton, pool));

Makes sense.
