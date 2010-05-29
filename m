From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/7] Add SVN revision parser and exporter
Date: Sat, 29 May 2010 09:06:45 -0500
Message-ID: <20100529140645.GA8338@progeny.tock>
References: <1274650832-7411-1-git-send-email-artagnon@gmail.com>
 <1274650832-7411-7-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 29 16:06:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIMgF-0002nT-Af
	for gcvg-git-2@lo.gmane.org; Sat, 29 May 2010 16:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753761Ab0E2OGV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 May 2010 10:06:21 -0400
Received: from mail-yw0-f198.google.com ([209.85.211.198]:40570 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071Ab0E2OGU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 May 2010 10:06:20 -0400
Received: by ywh36 with SMTP id 36so1417057ywh.4
        for <git@vger.kernel.org>; Sat, 29 May 2010 07:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=vdPl3wOJrN7VlDxEY4FGBscsWZcTkIZM+1+F1vd9s9k=;
        b=ATZnlvpX/kXMZpNa7nc6tDe5D6TiH8z8WGENTPSX1Jl1bLMljiNU9WJ8YCUNSJT/bs
         iUwlxn/ZnSBau87XEWWjEqmJfWy6VDKwCR4Ht+NSTOirqJJS215CkYkXbVJVCWjchrDC
         WH84Gi/TCnsao9ovL/MfTt4etiRx04HbHj7vc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=fPlQunZwiMX3NTYaC6SP8Z1Fu+loX4asZ7XdK+dzfPshpN3mRp4sJaS6cJiulF+aPr
         rfAVAoreQFYEb9+HZzQY4PujDrXLffyhDFZklh/VPxNTiB5pkPgzHH5BwrWng0LbDUh8
         RH4JclfV5YioXk5CDrXn6rNFSlaQkjy7uNKMg=
Received: by 10.231.158.132 with SMTP id f4mr2334407ibx.52.1275141978627;
        Sat, 29 May 2010 07:06:18 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id d9sm16184084ibl.10.2010.05.29.07.06.16
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 29 May 2010 07:06:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1274650832-7411-7-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147966>

Hi again,

Ramkumar Ramachandra wrote:

> repo_tree parses SVN revisions to build a Git objects, and use
> fast_export to emit them so they can be imported into the Git object
> store via a fast-import.

Wait, where are SVN revisions being parsed?  It seems that the repo
module maintains the exporter's state and provides a facility to
to call the fast_export module to write it out.

  repo_add(path, mode, blob_mark) is used to add a new file to
  the current commit.

  repo_modify is used to add a replacement for an existing file;
  it is implemented exactly the same way, but a check could be
  added later to distinguish the two cases.

  repo_copy copies a blob from a previous revision to the current
  commit.

  repo_replace modifies the content of a file from the current
  commit, if and only if it already exists.

  repo_delete removes a file or directory from the current commit.

  repo_commit calls out to fast_export to write the current commit
  to the fast-import stream in stdout.

  repo_diff is used by the fast_export module to write the changes
  for a commit.

  repo_reset erases the exporter's state, so valgrind can be happy.

> +void fast_export_modify(uint32_t depth, uint32_t *path, uint32_t mod=
e,
> +                        uint32_t mark)
> +{
> +    printf("M %06o :%d ", mode, mark);
> +    pool_print_seq(depth, path, '/', stdout);
> +    putchar('\n');
> +}

Mode must be 100644, 100755, 120000, or 160000.

[...]
> +typedef struct repo_dirent_s repo_dirent_t;
> +
> +struct repo_dirent_s {
> +    uint32_t name_offset;
> +    uint32_t mode;
> +    uint32_t content_offset;
> +};
> +
> +typedef struct repo_dir_s repo_dir_t;
> +
> +struct repo_dir_s {
> +    uint32_t size;
> +    uint32_t first_offset;
> +};
> +
> +typedef struct repo_commit_s repo_commit_t;
> +
> +struct repo_commit_s {
> +    uint32_t mark;
> +    uint32_t root_dir_offset;
> +};

Style: we don=E2=80=99t tend to use typedef to hide underlying struct d=
efinitions
(see Documentation/CodingStyle from linux-2.6.git, chapter 5, for some
explanation about why).

> +static uint32_t num_dirs_saved =3D 0;
> +static uint32_t num_dirents_saved =3D 0;

Style: leave out the initializer for bss-allocated variables.

> +static int repo_dirent_name_cmp(const void *a, const void *b)
> +{
> +    return (((repo_dirent_t *) a)->name_offset
> +            > ((repo_dirent_t *) b)->name_offset) -
> +        (((repo_dirent_t *) a)->name_offset
> +         < ((repo_dirent_t *) b)->name_offset);
> +}

Maybe some local variables would make this more readable:

 {
	const repo_dirent_t *dirent1 =3D a, *dirent2 =3D b;
	uint32_t a_offset =3D dirent1->name_offset;
	uint32_t b_offset =3D dirent2->name_offset;

	return (a_offset > b_offset) - (a_offset < b_offset);
 }

> +static repo_dir_t *repo_clone_dir(repo_dir_t *orig_dir, uint32_t pad=
ding)
> +{
> +    uint32_t orig_o, new_o, dirent_o;
> +    orig_o =3D dir_offset(orig_dir);
> +    if (orig_o < num_dirs_saved) {
> +        new_o =3D dir_with_dirents_alloc(orig_dir->size + padding);
> +        orig_dir =3D dir_pointer(orig_o);
> +        dirent_o =3D dir_pointer(new_o)->first_offset;
> +    } else {
> +        if (padding =3D=3D 0)
> +            return orig_dir;
> +        new_o =3D orig_o;
> +        dirent_o =3D dirent_alloc(orig_dir->size + padding);
> +    }
> +    memcpy(dirent_pointer(dirent_o), repo_first_dirent(orig_dir),
> +           orig_dir->size * sizeof(repo_dirent_t));
> +    dir_pointer(new_o)->size =3D orig_dir->size + padding;
> +    dir_pointer(new_o)->first_offset =3D dirent_o;
> +    return dir_pointer(new_o);
> +}

Is this for adding new entries to an existing directory?  It is
getting late, so I did not look it over carefully.

> +static char repo_path_buffer[REPO_MAX_PATH_LEN];
> +static repo_dirent_t *repo_read_dirent(uint32_t revision, char *path=
)
> +{
> +    char *ctx =3D NULL;
> +    uint32_t name =3D 0;
> +    repo_dir_t *dir =3D NULL;
> +    repo_dirent_t *dirent =3D NULL;
> +    dir =3D repo_commit_root_dir(commit_pointer(revision));
> +    strncpy(repo_path_buffer, path, REPO_MAX_PATH_LEN);
> +    repo_path_buffer[REPO_MAX_PATH_LEN - 1] =3D '\0';
> +    path =3D repo_path_buffer;
> +    for (name =3D pool_tok_r(path, "/", &ctx);
> +         ~name; name =3D pool_tok_r(NULL, "/", &ctx)) {
> +        dirent =3D repo_dirent_by_name(dir, name);
> +        if (dirent =3D=3D NULL) {
> +            return NULL;
> +        } else if (repo_dirent_is_dir(dirent)) {
> +            dir =3D repo_dir_from_dirent(dirent);
> +        } else {
> +            break;
> +        }
> +    }
> +    return dirent;
> +}

If a file "foo" exists and I ask for "foo/bar", this will return
the entry for foo.  Is that appropriate?

> +static void
> +repo_write_dirent(char *path, uint32_t mode, uint32_t content_offset=
,
> +                  uint32_t del)
> +{
> +    char *ctx;
> +    uint32_t name, revision, dirent_o, dir_o, parent_dir_o;
> +    repo_dir_t *dir;
> +    repo_dirent_t *dirent =3D NULL;
> +    revision =3D active_commit;
> +    dir =3D repo_commit_root_dir(commit_pointer(revision));
> +    dir =3D repo_clone_dir(dir, 0);
> +    commit_pointer(revision)->root_dir_offset =3D dir_offset(dir);
> +    strncpy(repo_path_buffer, path, REPO_MAX_PATH_LEN);
> +    repo_path_buffer[REPO_MAX_PATH_LEN - 1] =3D '\0';
> +    path =3D repo_path_buffer;
> +    for (name =3D pool_tok_r(path, "/", &ctx); ~name;
> +         name =3D pool_tok_r(NULL, "/", &ctx)) {
> +        parent_dir_o =3D dir_offset(dir);
> +        dirent =3D repo_dirent_by_name(dir, name);
> +        if (dirent =3D=3D NULL) {

static repo_dir_t *add_subdir(uint32_t parent_dir_o, repo_dir_t *dir,
                              uint32_t name)
{

> +            dir =3D repo_clone_dir(dir, 1);
> +            dirent =3D &repo_first_dirent(dir)[dir->size - 1];
> +            dirent->name_offset =3D name;
> +            dirent->mode =3D REPO_MODE_DIR;
> +            qsort(repo_first_dirent(dir), dir->size,
> +                  sizeof(repo_dirent_t), repo_dirent_name_cmp);
> +            dirent =3D repo_dirent_by_name(dir, name);
> +            dir_o =3D dir_with_dirents_alloc(0);
> +            dirent->content_offset =3D dir_o;
> +            dir =3D dir_pointer(dir_o);

}

> +        } else if ((dir =3D repo_dir_from_dirent(dirent))) {
> +            dirent_o =3D dirent_offset(dirent);
> +            dir =3D repo_clone_dir(dir, 0);
> +            if (dirent_o !=3D ~0)
> +                dirent_pointer(dirent_o)->content_offset =3D dir_off=
set(dir);
> +        } else {

static repo_dir_t *replace_with_empty_dir(uint32_t dirent)
{

> +            dirent->mode =3D REPO_MODE_DIR;
> +            dirent_o =3D dirent_offset(dirent);
> +            dir_o =3D dir_with_dirents_alloc(0);
> +            dirent =3D dirent_pointer(dirent_o);
> +            dir =3D dir_pointer(dir_o);
> +            dirent->content_offset =3D dir_o;

}

> +        }
> +    }
> +    if (dirent) {

When would it be NULL?  Is an empty path allowed?

static void fill_dirent(repo_dirent_t *dirent,
                        uint32_t mode, uint32_t content_offset,
                        uint32_t parent_dir_o, int del)
{

> +        dirent->mode =3D mode;
> +        dirent->content_offset =3D content_offset;
> +        if (del && ~parent_dir_o) {
> +            dirent->name_offset =3D ~0;
> +            dir =3D dir_pointer(parent_dir_o);
> +            qsort(repo_first_dirent(dir), dir->size,
> +                  sizeof(repo_dirent_t), repo_dirent_name_cmp);
> +            dir->size--;
> +        }

}

> +    }
> +}
[...]

> +static void
> +repo_git_add_r(uint32_t depth, uint32_t *path, repo_dir_t *dir);
> +
> +static void
> +repo_git_add(uint32_t depth, uint32_t *path, repo_dirent_t *dirent)
> +{
> +    if (repo_dirent_is_dir(dirent)) {
> +        repo_git_add_r(depth, path, repo_dir_from_dirent(dirent));
> +    } else {
> +        fast_export_modify(depth, path, dirent->mode, dirent->conten=
t_offset);
> +    }
> +}

Just curious: does gcc notice the tail calls?

> +static void
> +repo_git_add_r(uint32_t depth, uint32_t *path, repo_dir_t *dir)
> +{
> +    uint32_t o;
> +    repo_dirent_t *de;
> +    de =3D repo_first_dirent(dir);
> +    for (o =3D 0; o < dir->size; o++) {
> +        path[depth] =3D de[o].name_offset;
> +        repo_git_add(depth + 1, path, &de[o]);
> +    }
> +}

Can this overflow the path stack?

> +
> +static void
> +repo_diff_r(uint32_t depth, uint32_t *path, repo_dir_t *dir1,
> +            repo_dir_t *dir2)
> +{
> +    repo_dirent_t *de1, *de2, *max_de1, *max_de2;
> +    de1 =3D repo_first_dirent(dir1);
> +    de2 =3D repo_first_dirent(dir2);
> +    max_de1 =3D &de1[dir1->size];
> +    max_de2 =3D &de2[dir2->size];
> +
> +    while (de1 < max_de1 && de2 < max_de2) {
> +        if (de1->name_offset < de2->name_offset) {
> +            path[depth] =3D (de1++)->name_offset;
> +            fast_export_delete(depth + 1, path);
> +        } else if (de1->name_offset =3D=3D de2->name_offset) {
> +            path[depth] =3D de1->name_offset;
> +            if (de1->content_offset !=3D de2->content_offset) {
> +                if (repo_dirent_is_dir(de1) && repo_dirent_is_dir(de=
2)) {
> +                    repo_diff_r(depth + 1, path,
> +                                repo_dir_from_dirent(de1),
> +                                repo_dir_from_dirent(de2));
> +                } else {
> +                    if (repo_dirent_is_dir(de1) !=3D repo_dirent_is_=
dir(de2)) {
> +                        fast_export_delete(depth + 1, path);
> +                    }
> +                    repo_git_add(depth + 1, path, de2);
> +                }
> +            }
> +            de1++;
> +            de2++;
> +        } else {
> +            path[depth] =3D de2->name_offset;
> +            repo_git_add(depth + 1, path, de2++);
> +        }

Might be easier to read the other way around:

		if (de1->name_offset < de2->name_offset) {
			path[depth] =3D (de1++)->name_offset;
			fast_export_delete(depth + 1, path);
			continue;
		}
		if (de1->name_offset > de2->name_offset) {
			path[depth] =3D de2->name_offset;
			repo_git_add(depth + 1, path, de2++);
			continue;
		}
		... matching paths case ...

> +    }
> +    while (de1 < max_de1) {
> +        path[depth] =3D (de1++)->name_offset;
> +        fast_export_delete(depth + 1, path);
> +    }
> +    while (de2 < max_de2) {
> +        path[depth] =3D de2->name_offset;
> +        repo_git_add(depth + 1, path, de2++);
> +    }
> +}
[...]

> +void repo_commit(uint32_t revision, char *author, char *log, char *u=
uid,
> +                 char *url, time_t timestamp)
> +{
> +    if (revision =3D=3D 0) {
> +        active_commit =3D commit_alloc(1);
> +        commit_pointer(active_commit)->root_dir_offset =3D
> +            dir_with_dirents_alloc(0);
> +    } else {
> +        fast_export_commit(revision, author, log, uuid, url, timesta=
mp);
> +    }
> +    num_dirs_saved =3D dir_pool.size;
> +    num_dirents_saved =3D dirent_pool.size;

I did not carefully trace the cases where repo_clone_dir may reuse a
dir.  I would be happier if someone else does.

The rest looked good to me, for what it=E2=80=99s worth.

Thanks,
Jonathan
