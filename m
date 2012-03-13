From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v2 2/2] index-pack: support multithreaded delta resolving
Date: Tue, 13 Mar 2012 00:32:34 +0000
Message-ID: <4F5E95A2.8050106@ramsay1.demon.co.uk>
References: <1331519549-28090-1-git-send-email-pclouds@gmail.com> <1331519549-28090-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 19:16:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7WGm-0006pP-7A
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 19:16:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759240Ab2CMSQT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Mar 2012 14:16:19 -0400
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:45074 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758568Ab2CMSQS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Mar 2012 14:16:18 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1S7WGd-0007Ge-ZS; Tue, 13 Mar 2012 18:16:17 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <1331519549-28090-3-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193051>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
[snipped]
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  I changed Ramsay's mutex patch a little bit and incorporate it here.
>  Ramsay, it'd be great if you could try it again on MinGW

Hmm, well do you want the good news, or the bad news ... :-D

=46irst, I should say that I feel like I'm doing a very bad job of
communicating, so let me apologize for that and hope that this time
I make a better job of it!

This patch breaks the build on MinGW, since the emulation code has not
(thus far) included an implementation of pthread_key_delete(). I simply
commented out the call to that function, in cleanup_thread(), so that I
could test the remainder of the patch.

Although this patch is an improvement on previous patches, it still fai=
ls
in *exactly* the same way as earlier attempts.

I probably didn't make clear before that 'nr_threads' has been given to=
o
many duties, which is the main reason for me introducing a new variable
'threads_active'. For example, ...

>  builtin/index-pack.c             |  198 ++++++++++++++++++++++++++++=
++++++----
>  3 files changed, 192 insertions(+), 18 deletions(-)
>=20

[snipped]

> +static inline void lock_mutex(pthread_mutex_t *mutex)
> +{
> +	if (nr_threads > 1)
> +		pthread_mutex_lock(mutex);
> +}

What is this condition testing (ie. what does it mean)? Does it mean:

    1. there are some threads currently running ?
    2. the mutex variables are in a usable state ?

Does this expression always express the same invariant?

The answer, of course, is *no*.

Let us consider the call to parse_pack_objects() at line 1367. Let us
suppose that we have been asked to use threads (from the config file,
the command-line, or simply !NO_PTHREADS), so that when we call the
parse_pack_objects() function nr_threads > 1.

Note that, at this point, no threads are active and the mutex variables
have not been initialised.

Now, at the beginning of parse_pack_objects(), we find some 'first pass=
'
processing [for (i =3D 0; i < nr_objects; i++) ... lines 839-851], whic=
h
includes a call to sha1_object() at line 848. sha1_object() in turn has
an invocation of the read_lock() macro (line 552), which in turn calls
lock_mutex() with a pointer to the read_mutex.

Note that, at this point, no threads are active and the mutex variables
have not been initialised.

Also note that "nr_threads > 1" is true. At this point, nr_threads is s=
till
playing the "this is how many threads I have been requested to create" =
role.
But again, no threads have been created yet, the mutex variables haven'=
t been
initialised, and ... well, *boom*.

So, in order to get it to work on MinGW (and this time I only tested on=
 MinGW),
I had to apply the patch below (look familiar?).

[I ran the same four tests as before, five times in a row. On *one* occ=
asion
t5300.22 (verify-pack catches a corrupted type/size of the 1st packed o=
bject data)
failed because the 'dd' command crashed! So, maybe there is a problem l=
urking.]

ATB,
Ramsay Jones

-- >8 --
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 7e3b287..6679734 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -69,6 +69,7 @@ static int nr_processed;
 static int nr_deltas;
 static int nr_resolved_deltas;
 static int nr_threads;
+static int threads_active;
=20
 static int from_stdin;
 static int strict;
@@ -105,13 +106,13 @@ static pthread_key_t key;
=20
 static inline void lock_mutex(pthread_mutex_t *mutex)
 {
-	if (nr_threads > 1)
+	if (threads_active)
 		pthread_mutex_lock(mutex);
 }
=20
 static inline void unlock_mutex(pthread_mutex_t *mutex)
 {
-	if (nr_threads > 1)
+	if (threads_active)
 		pthread_mutex_unlock(mutex);
 }
=20
@@ -125,14 +126,16 @@ static void init_thread(void)
 	pthread_mutex_init(&work_mutex, NULL);
 	pthread_key_create(&key, NULL);
 	thread_data =3D xcalloc(nr_threads, sizeof(*thread_data));
+	threads_active =3D 1;
 }
=20
 static void cleanup_thread(void)
 {
+	threads_active =3D 0;
 	pthread_mutex_destroy(&read_mutex);
 	pthread_mutex_destroy(&counter_mutex);
 	pthread_mutex_destroy(&work_mutex);
-	pthread_key_delete(key);
+	/*pthread_key_delete(key);*/
 	nr_threads =3D 1;
 	free(thread_data);
 }
-- 8< --
