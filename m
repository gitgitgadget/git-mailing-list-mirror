From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Git exhausts memory.
Date: Tue, 05 Apr 2011 16:56:20 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1104051655310.28032@xanadu.home>
References: <BANLkTin=yUtzbZjs_92FHDfs62VFFuLHwg@mail.gmail.com>
 <alpine.LFD.2.00.1104021103130.28032@xanadu.home>
 <BANLkTikRGQ45xvWvisMhXi4Hu2r_0GS=Gg@mail.gmail.com>
 <alpine.LFD.2.00.1104031110150.28032@xanadu.home>
 <BANLkTinCwZG3+0Ss8o9ODptg=L8LKKN7aQ@mail.gmail.com>
 <BANLkTinU7x16yp+y-HW9UhkVn9SftOJCcA@mail.gmail.com>
 <4D9B47D2.6050909@ira.uka.de>
 <BANLkTikanSa3D1Bd8kSySPWQhcj1y8N+qA@mail.gmail.com>
 <7vzko4mw44.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Shawn Pearce <spearce@spearce.org>,
	Holger Hellmuth <hellmuth@ira.uka.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Alif Wahid <alif.wahid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 22:56:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7DIj-0001tI-Pz
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 22:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754125Ab1DEU4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 16:56:32 -0400
Received: from relais.videotron.ca ([24.201.245.36]:24098 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754095Ab1DEU4c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 16:56:32 -0400
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz23.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LJ700H3U64ZDIE0@vl-mo-mrz23.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 05 Apr 2011 16:55:47 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vzko4mw44.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170912>

On Tue, 5 Apr 2011, Junio C Hamano wrote:

> Shawn Pearce <spearce@spearce.org> writes:
> 
> > On Tue, Apr 5, 2011 at 12:48, Holger Hellmuth <hellmuth@ira.uka.de> wrote:
> >> On 04.04.2011 16:57, Nguyen Thai Ngoc Duy wrote:
> >>>
> >>> Should we change the default to not delta if a blob exceeds predefined
> >>> limit (say 128M)? People who deliberately wants to delta them can
> >>> still set delta attr. 1.8.0 material maybe?
> >>
> >> Isn't this already done with the config variable core.bigFileThreshold ?
> >>
> >> documentation says: "Files larger than this size are stored deflated,
> >> without attempting delta compression. ... Default is 512 MiB on all
> >> platforms."
> >
> > This is only implemented inside of fast-import. pack-objects does not
> > honor this variable.
> 
> Do you mean perhaps we should?

Yes.

Acked-by: Nicolas Pitre <nico@fluxnic.net>


>  builtin/pack-objects.c |    8 ++++++--
>  cache.h                |    1 +
>  config.c               |    6 ++++++
>  environment.c          |    1 +
>  fast-import.c          |    5 -----
>  5 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index b0503b2..f402a84 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1142,8 +1142,12 @@ static void get_object_details(void)
>  		sorted_by_offset[i] = objects + i;
>  	qsort(sorted_by_offset, nr_objects, sizeof(*sorted_by_offset), pack_offset_sort);
>  
> -	for (i = 0; i < nr_objects; i++)
> -		check_object(sorted_by_offset[i]);
> +	for (i = 0; i < nr_objects; i++) {
> +		struct object_entry *entry = sorted_by_offset[i];
> +		check_object(entry);
> +		if (big_file_threshold <= entry->size)
> +			entry->no_try_delta = 1;
> +	}
>  
>  	free(sorted_by_offset);
>  }
> diff --git a/cache.h b/cache.h
> index 2674f4c..316d85f 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -573,6 +573,7 @@ extern int core_compression_seen;
>  extern size_t packed_git_window_size;
>  extern size_t packed_git_limit;
>  extern size_t delta_base_cache_limit;
> +extern uintmax_t big_file_threshold;
>  extern int read_replace_refs;
>  extern int fsync_object_files;
>  extern int core_preload_index;
> diff --git a/config.c b/config.c
> index 0abcada..d06fb19 100644
> --- a/config.c
> +++ b/config.c
> @@ -567,6 +567,12 @@ static int git_default_core_config(const char *var, const char *value)
>  		return 0;
>  	}
>  
> +	if (!strcmp(var, "core.bigfilethreshold")) {
> +		long n = git_config_int(var, value);
> +		big_file_threshold = 0 < n ? n : 0;
> +		return 0;
> +	}
> +
>  	if (!strcmp(var, "core.packedgitlimit")) {
>  		packed_git_limit = git_config_int(var, value);
>  		return 0;
> diff --git a/environment.c b/environment.c
> index f4549d3..3d1ab51 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -35,6 +35,7 @@ int fsync_object_files;
>  size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
>  size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
>  size_t delta_base_cache_limit = 16 * 1024 * 1024;
> +uintmax_t big_file_threshold = 512 * 1024 * 1024;
>  const char *pager_program;
>  int pager_use_color = 1;
>  const char *editor_program;
> diff --git a/fast-import.c b/fast-import.c
> index 65d65bf..3e4e655 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -274,7 +274,6 @@ struct recent_command {
>  /* Configured limits on output */
>  static unsigned long max_depth = 10;
>  static off_t max_packsize;
> -static uintmax_t big_file_threshold = 512 * 1024 * 1024;
>  static int force_update;
>  static int pack_compression_level = Z_DEFAULT_COMPRESSION;
>  static int pack_compression_seen;
> @@ -3206,10 +3205,6 @@ static int git_pack_config(const char *k, const char *v, void *cb)
>  		max_packsize = git_config_ulong(k, v);
>  		return 0;
>  	}
> -	if (!strcmp(k, "core.bigfilethreshold")) {
> -		long n = git_config_int(k, v);
> -		big_file_threshold = 0 < n ? n : 0;
> -	}
>  	return git_default_config(k, v, cb);
>  }
>  
> 
